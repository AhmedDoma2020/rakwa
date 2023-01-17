import 'package:get/get.dart';
import 'package:rakwa/widget/Loading/loading_dialog.dart';

void setLoading(){
  Get.dialog(const Loader());
}