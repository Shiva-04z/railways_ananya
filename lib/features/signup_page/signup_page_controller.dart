import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:railways_shiva/routes/routes_constant.dart';
import 'package:railways_shiva/core/globals.dart' as glb;

class SignUpPageController extends GetxController {
  RxBool isSet = false.obs;
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late UserCredential user;

  googleButton() async {
    await signInGoogle();
  }

  facebookButton() async {
    await signInFacebook();
  }
  signInFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
        FacebookAuthProvider.credential(accessToken.tokenString);

        user = await FirebaseAuth.instance.signInWithCredential(credential);
        Get.snackbar("", "Login Successful");
        glb.isLogin.value = true;
        setLoginValue();
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar("", "Login Cancelled");
      } else {
        Get.snackbar("", "Login Failed");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("", e.code);
      print(e.code);
    } catch (e) {
      Get.snackbar("", e.toString());
      print(e.toString);
    }
  }

  signInGoogle() async {
    try{
      GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar("","Login Successful");
      glb.isLogin.value = true;
      setLoginValue();}
    on FirebaseAuthException catch(e)
    {
      Get.snackbar("", e.code);
    }
    catch(e)
    {
      Get.snackbar("", e.toString());
    }
  }

  Future<void> setLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", glb.isLogin.value);
    glb.loginCheck();
  }

  emailValidator(value) {
    if (value!.isEmpty) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }
  nameValidator(value) {
    if (value!.isEmpty) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }
  phoneValidator(value) {
    if (value!.isEmpty) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }
  toSignin() {
    Get.offNamed(RoutesConstant.loginPage);
  }

  passwordValidator(value) {
    if (value!.length < 6) {
      return "Please enter a valid password at least of length 6";
    } else {
      return null;
    }
  }

  withPhone() {
    Get.toNamed(RoutesConstant.phoneVerify);
  }

  formValidate() async {
    var isValid = signUpKey.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passWordController.text);
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passWordController.text);
        glb.isLogin.value = true;
        setLoginValue();
      } catch (e) {
        Get.snackbar("", e.toString());
      }
    }
  }
}
