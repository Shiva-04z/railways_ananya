import 'package:railways_shiva/core/globals.dart' as glb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:railways_shiva/routes/routes_constant.dart';

class LoginPageController extends GetxController {
  RxBool isSet = false.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  late UserCredential user;

  elevatedButton() {
    formValidate();
    glb.loginCheck();
  }

  googleButton() async {
    await signInGoogle();
  }

  facebookButton() async {
    await signInFacebook();
  }

  Future<void> setLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", glb.isLogin.value);
    glb.loginCheck();
  }

  withPhone() {
    Get.toNamed(RoutesConstant.phoneVerify);
  }

  signInGoogle() async {
    try {
      GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar("", "Login Successful");
      glb.isLogin.value = true;
      setLoginValue();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("", e.code);
    } catch (e) {
      Get.snackbar("", e.toString());
    }
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

  emailValidator(value) {
    if (value!.isEmpty) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  passwordValidator(value) {
    if (value!.length < 6) {
      return "Please enter a valid password at least of length 6";
    } else {
      return null;
    }
  }

  toRegister() {
    Get.toNamed(RoutesConstant.signUpPage);
  }

  formValidate() async {
    var isValid = loginKey.currentState!.validate();
    if (!isValid) {
      return null;
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passWordController.text);
        glb.isLogin.value = true;
        setLoginValue();
      } catch (e) {
        Get.snackbar("", e.toString());
      }
    }
  }

  sendLink() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email2Controller.text);
      Get.snackbar("", "Email Sent");
    } catch (e) {
      Get.snackbar("", e.toString());
    }
  }

  forgotPassword() {
    Get.defaultDialog(
      title: "Verify Email",
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 350,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Image(
              image: AssetImage("assets/img_8.png"),
              height: 100,
              width: 100,
            ),
            const Text(
              "Enter Email",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: email2Controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24))),
            ),
            ElevatedButton(
                onPressed: () {
                  sendLink();
                },
                child: const Text("Send Link"))
          ],
        ),
      ),
    );
  }
}
