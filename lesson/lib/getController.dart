import 'package:get/get.dart';

class dialogController extends GetxController{
  void showDialog(){
    Get.defaultDialog(
      title: "Attention",
      middleText: "This is the dialog",
      textConfirm: "OK",
      textCancel: "Cancel",
      confirmTextColor: Get.isDarkMode ? Get.theme.primaryColor : Get.theme.cardColor,
      onConfirm: () => Get.back(),
      barrierDismissible: false,
      
    );
  }
}