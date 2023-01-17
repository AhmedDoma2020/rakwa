import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  XFile? image_file;
  List<XFile>? images;
  ImagePicker _imagePicker = ImagePicker();
  var url;
  List urls =[];

  Future<void> getImageFromGallary() async {
    image_file = await _imagePicker.pickImage(source: ImageSource.gallery);
   if(image_file!.path.isNotEmpty){
     url = File(image_file!.path);
   }
    update();
  }

  Future<void> getImageFromCamera() async {
    image_file = await _imagePicker.pickImage(source: ImageSource.camera);
    url = File(image_file!.path);
    update();
  }

  Future<void> getMultiImage()async{
    images = await _imagePicker.pickMultiImage();
    update();
  }

}
