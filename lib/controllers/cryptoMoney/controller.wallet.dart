import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../../constWidgets/snackBar.dart';
import '../../services/service.profile.dart';
import '../../views/dialogbox/dialog.metaMask.dart';
import '../profile/controller.profil.dart';

class WalletController extends GetxController {
  var account = "";
  var connected = false.obs;
  late Rx<bool> hasAddress;

  double balance = 0.0;
  final sessionStorage = WalletConnectSecureStorage();
  late WalletConnect connector;
  Rx<bool> downloading = false.obs;
  late double priceEther;

  ////0 edit profile , 1 connect

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController disconnectController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    super.onInit();
    initialise();
  }

  final ethereum = Web3Client(
      'https://sepolia.infura.io/v3/d13837448f1c4c4b90b4e4d5c80a2550',
      Client());

  initialise() async {
    hasAddress = (Get.put(ProfileController()).user.addressCrypto != null).obs;
    switchState();
    try {
      final session = await sessionStorage.getSession();
      connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        session: session,
        sessionStorage: sessionStorage,
        clientMeta: const PeerMeta(
          name: 'Crypto Khidma',
          description: 'Crypto Khidma Mobile App',
          url: 'https://www.walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );
      connector.registerListeners(onConnect: (session) async {
        getDetails(session);
      });
      connector.registerListeners(onSessionUpdate: (session) async {
        getDetails(session);
      });

      if (connector.connected) {
        connector.reconnect();
        await getDetails(session!);
      }

      connector.on('connect', (WalletConnectSession session) {
        getDetails(session);
      });

      connector.on('session_update', (WalletConnectSession session) async {
        getDetails(session);
      });

      connector.on('disconnect', (session) => print(session));
    } catch (e) {
      snackBarModel("Failed", "Something went wrong", true);
    }
    switchState();
  }

  connect() async {
    try {
      await connector.connect(
        chainId: 11155111,
        onDisplayUri: (uri) async {
          try {
            await launchUrl(Uri.parse(uri));
            btnController.stop();
          } catch (e) {
            if (e.toString().contains("ACTIVITY_NOT_FOUND")) {
              Get.dialog(dialogMetaMask());
            }
            btnController.stop();
          }
        },
      );
    } catch (e) {
      Get.back();
      snackBarModel("Failed", "Something went wrong", true);
      btnController.stop();
    }
    btnController.stop();
  }

  addAddress() async {
    var res = await ProfileService.updateAddress(account);
    if (res.error) {
      snackBarModel("Failed", "Something went wrong", true);
      btnController.stop();
    } else {
      LocalController.setProfile(res.data);
      Get.offAll(() => const WrapperWidget());
      snackBarModel("Success", "Address added", false);
    }
  }

  getDetails(session) async {
    account = session.accounts[0];
    var res = await ethereum.getBalance(EthereumAddress.fromHex(account));
    balance = res.getValueInUnit(EtherUnit.ether);
    connected.value = true;
  }

  switchState() => downloading.value = !downloading.value;

  disconnect() async {
    try {
      await connector.killSession();
      await Future.delayed(const Duration(milliseconds: 2000));
      connected.value = false;
      account = "";
      disconnectController.stop();
      Get.back();
    } catch (e) {
      snackBarModel("Failed", "Something went wrong", true);
    }
  }

  logOut() async {
    final session = await sessionStorage.getSession();
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: const PeerMeta(
        name: 'Crypto Khidma',
        description: 'Crypto Khidma Mobile App',
        url: 'https://www.walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );
    await connector.killSession();
  }
}
