
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:railways_shiva/core/globals.dart'as glb;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:railways_shiva/routes/routes_constant.dart';

class HomePageController extends GetxController {
  RxInt selectedValue = 0.obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onReady()
  {

    selectedValue.value=0;


  }

  void onItemTapped(int value) {
    selectedValue.value = value;
    if(selectedValue.value==1)
      {
        Get.toNamed(RoutesConstant.searchPage);

      }
    if(selectedValue.value==2)
      {
        Get.toNamed(RoutesConstant.readPage);
      }
    if(selectedValue.value ==3)
      {
signOut();
      }
  }



  void signOut()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     GoogleSignIn().signOut();
     FirebaseAuth.instance.signOut();
     glb.isLogin.value=false;
     prefs.setBool("isLogin", glb.isLogin.value);
     Get.offNamed(RoutesConstant.loginPage);

  }


  void toUpdate()
  {
    Get.toNamed(RoutesConstant.updatePage);
  }

  void toUpload()
  {
    Get.toNamed(RoutesConstant.searchPage);
  }

  void toRead()
  {
    Get.toNamed(RoutesConstant.readPage);
  }

}