import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../../constWidgets/snackBar.dart';
import '../../models/model.project.dart';


class RatingCryptoController extends GetxController{

  ProjectModel project;
  int rating;
  String comment;

  RatingCryptoController({required this.project,required this.rating,required this.comment});

  final ethClient = Web3Client(
      'https://sepolia.infura.io/v3/d13837448f1c4c4b90b4e4d5c80a2550',
      Client());

  ///// smart contract
  Future<DeployedContract> loadContract() async {
    String abiCode =
    await rootBundle.loadString("assets/contracts/abiRating.json");
    String contractAddress = "0x8937b8639b1Bc86cA6dBB2197cef233Cd021B8F0";

    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "khidmaRate"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future rate() async {

    try {
      await loadContract();
      final credentials =  EthPrivateKey.fromHex(
          "b89082196513e5918a12e1dc1d1de5aa07dbb6efdc46f4c6134f5cca0e295978");
      final contract = await loadContract();
      final function = contract.function('rateArtisanClient');
      await ethClient.sendTransaction(
          credentials,
          Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [
              EthereumAddress.fromHex(project.client.addressCrypto!),
              EthereumAddress.fromHex(project.artisan.addressCrypto!),
              project.id,
              project.title,
              BigInt.from(rating),
              comment
            ],
          ),
          chainId: 11155111
      );
    } catch (e) {
      snackBarModel("Failed", e.toString(), true);
    }
  }


}