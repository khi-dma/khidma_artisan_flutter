import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../../../models/model.CommentClient.dart';
import '../../../services/service.comment.dart';

class CommentsController extends GetxController{

  @override
  onInit(){
    super.onInit();
    getComments();
  }

  List<CommentArtisanModel> comments=[] ;
  var error = false.obs;
  var downloading = false.obs;
  var selected = 5.obs;
  String idArtisan;
  CommentsController({required this.idArtisan});

  updateSelected(int newValue){
    selected.value= newValue;
    getComments();
  }

  getComments()async {
    switchState();
    var res = await RatingService.getComments(idArtisan, selected.value.toString());
    error.value=res.error;
    comments=res.data;
    switchState();
  }

  switchState()=>downloading.value = !downloading.value;

}