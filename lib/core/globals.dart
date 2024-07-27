import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:railways_shiva/routes/routes_constant.dart';

RxBool isLogin = true.obs;
RxBool isProfileUpdated = false.obs;
RxString uploadedImages = "".obs;
Rx<String>passengerDoc ="".obs;
RxString selected = "".obs;
RxBool isAdmin = false.obs;



loginCheck() {

  if(isLogin.value)
  {
    Get.offNamed(RoutesConstant.homePage);}
  else
  {
    Get.offNamed(RoutesConstant.loginPage);
  }
}