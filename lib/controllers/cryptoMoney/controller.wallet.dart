import 'dart:ui';

import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../../constWidgets/snackBar.dart';
import '../../services/service.profile.dart';
import '../../views/BottomBar/widget.bottomBar.dart';
import '../../views/dialogbox/dialog.metaMask.dart';
import '../profile/controller.profil.dart';

class WalletController extends GetxController {
  var account = "";
  var connected = false.obs;

  double balance = 0.0;
  Rx<bool> downloading = false.obs;

  ////0 edit profile , 1 connect

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController disconnectController =
      RoundedLoadingButtonController();

  disconnectAccount(){
    LocalController.clear();
    Get.deleteAll();

    Get.offAll(() => const WrapperWidget());
    disconnectController.stop();
  }

  @override
  void onInit() {
    super.onInit();
    initialise();
  }

  final ethereum = Web3Client(
      'https://sepolia.infura.io/v3/d13837448f1c4c4b90b4e4d5c80a2550',
      Client());

  late Web3App wcClient;

  late SessionData session;

  initialise() async {
    switchState();
    try {
      wcClient = await Web3App.createInstance(
        relayUrl: 'wss://relay.walletconnect.com',
        // The relay websocket URL, leave blank to use the default
        projectId: 'ef72bc20ab2ae0aa91585d5e72c825c1',
        metadata: const PairingMetadata(
          name: 'dApp (Requester)',
          description: 'A dapp that can request that transactions be signed',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    } catch (e) {
      snackBarModel("Failed", "Something went wrong", true);
    }

    switchState();
  }

  connect() async {
    try {
      ConnectResponse resp = await wcClient.connect(requiredNamespaces: {
        'eip155': const RequiredNamespace(
          chains: ['eip155:11155111'], // Ethereum chain
          methods: ['eth_signTransaction'], events: [], // Requestable Methods
        ),
      });
      Uri? uri = resp.uri;
      launchUrl(uri!);
      session = await resp.session.future;
      getDetails(session);
      btnController.stop();
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

  getDetails(SessionData session) async {
    account =
        session.toJson()["namespaces"]["eip155"]["accounts"][0].split(":")[2];
    var res = await ethereum.getBalance(EthereumAddress.fromHex(account));
    balance = res.getValueInUnit(EtherUnit.ether);
    connected.value = true;
  }

  switchState() => downloading.value = !downloading.value;

  disconnect() async {
    try {
      wcClient.disconnectSession(
          topic: session.topic,
          reason: WalletConnectError( code: 20, message: 'error'));

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
    /*final session = await sessionStorage.getSession();
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
    await connector.killSession();*/
  }
}
