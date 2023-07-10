
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Identity/controller.canceled.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.verifyPhoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Home/widget.home.dart';
import 'package:khidma_artisan_flutter/views/Identity/widget.canceled.dart';
import 'package:khidma_artisan_flutter/views/Identity/widget.uploadIdentity.dart';
import 'package:khidma_artisan_flutter/views/Identity/widget.verifyIdentity.dart';

import '../../views/BottomBar/widget.bottomBar.dart';
import '../../views/Paiment/metaMask/widget.MetaMask.dart';

class WrapperController{
  Widget current(){
    var state = LocalController.getState();
    switch(state){
      case 0:{
        return LocalController.getProfile().addressCrypto==null || LocalController.getProfile().addressCrypto!.isEmpty ? const MetaMaskWidget():const BottomBarWidget();
      }
      case 2:{
        return const UploadIdentityWidget();
      }
      case 3:{
        return const VerifyIdentity();
      }
      case 4:{
        return const CanceledIdentityWidget();
      }
      default:{
        return  const LogInWidget();
      }
    }
  }

}