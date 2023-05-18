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


String dateToString(String dateString){
  DateTime date = DateTime.parse(dateString);
  return DateFormat('d MMMM').format(date);
}