
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/model/all_messages_model.dart';

class GetAllMessageController extends GetxController{
  List<AllMessagesModel> allMessages=[];
  bool loadingGetAllMessage =false;
  Future<void> getAllMessage()async{
    loadingGetAllMessage=true;
    update(["updateAllMessage"]);
    try{
      allMessages =  await MessagesApiCpntroller().getAllMessages();
    }catch (e){
      printDM(" e in getAllMessage is => $e");
      allMessages=[];
    }
    loadingGetAllMessage=false;
    update(["updateAllMessage"]);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    getAllMessage();
    super.onInit();
  }
}