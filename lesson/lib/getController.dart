import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class dialogController extends GetxController{

  void showDialog(VoidCallback ontap){
    Get.defaultDialog(
      title: "Attention",
      middleText: "Are you sure!",
      textConfirm: "OK",
      textCancel: "Cancel",
      confirmTextColor: Get.isDarkMode ? Get.theme.primaryColor : Get.theme.cardColor,
      onConfirm:ontap,
      barrierDismissible: false,
      
    );
  }
}