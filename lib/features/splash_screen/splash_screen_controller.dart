import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:railways_shiva/core/globals.dart' as glb;

class SplashScreenController extends GetxController {
  void retriveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    glb.isLogin.value = prefs.getBool("isLogin")!;
  }

  @override
  Future <void> onReady() async{
    retriveValues();
    await Future.delayed(const Duration(seconds: 2));
    glb.loginCheck();

  }

}
