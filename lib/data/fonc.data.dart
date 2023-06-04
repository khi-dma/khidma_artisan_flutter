import 'dart:io';
import 'package:intl/intl.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<String> takePic(double? ratioX ,double? ratioY)async {
  File? croppedFileImage ;
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image != null) {
    croppedFileImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: ratioX ==null || ratioY ==null ? null : CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );
    return croppedFileImage!.path ;
  }
  return "" ;
}


String dateToStringPost(String dateString){
  DateTime date = DateTime.parse(dateString);
  return DateFormat('d MMMM').format(date);
}


String dateToStringMessage(String dateString){
  DateTime dateTime = DateTime.parse(dateString);
  DateFormat formatter = DateFormat('h:mm a');
  String formattedTime = formatter.format(dateTime);
  return formattedTime;
}

String dateToStringPreProject(DateTime dateTime){
  String formattedDateTime = DateFormat("dd MMM yyyy hh:mm a").format(dateTime);
  return formattedDateTime;
}

String dateToStringListProject(DateTime dateTime){
  String formattedDateTime = DateFormat("dd MMM hh:mm a").format(dateTime);
  return formattedDateTime;
}