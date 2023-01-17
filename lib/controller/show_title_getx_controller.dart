import 'package:get/get.dart';

class ShowTitleGetxController extends GetxController {
  bool show = false;

  showTitle({required bool newShow}) {
    show = newShow;
    update();
  }
}
