import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:railways_shiva/core/globals.dart' as glb;
import 'package:railways_shiva/routes/routes_constant.dart';
import 'package:telephony/telephony.dart';

class PhonePageController extends GetxController  {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxString verificationId = "".obs;
  RxString smsCode = "".obs;
  RxBool isCorrectNumber = false.obs;
  RxBool otpSent = false.obs;
  RxInt counter = 0.obs;
  RxBool flag = true.obs;
  Timer? _timer;
  RxBool verified = true.obs;
  RxString codeValue = "".obs;
  String appSignature = "";
  final Telephony telephony =Telephony.instance;

  



  void StartListening()
  {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          if(message.body!.contains("railway-2c07d.firebaseapp.com"))
            codeValue.value= message.body!.substring(0,6);
          
          // Handle message
        },
        listenInBackground: false
    );
  }

  @override
  void onInit() {
    StartListening();
    super.onInit();}


  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();

  }



  void resendOtp() {
    if (counter.value == 0) {
      phoneAuthentication();
      startTimer();
    }
  }

  void startTimer() {
    counter.value = 30;
    flag.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        flag.value = true;
        timer.cancel();
      }
    });
  }

  void onEdit() {
    otpSent.value = false;
  }

  Future<void> setLoginValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", glb.isLogin.value);
    glb.loginCheck();
  }

  String? validatePhone(String? value) {
    if (value == null || value.length != 10) {
      return "Please enter Number correctly";
    } else {
      return null;
    }
  }

  Future<void> verifyOTP() async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otpController.text,
        ),
      );
      verified.value = true;
      Get.defaultDialog(
        title: "Success",
        content: Column(
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/successful.png"),
                width: 150,
                height: 150,
              ),
            ),
            const Text("OTP verified Successfully"),
            ElevatedButton(
              onPressed: () {
                glb.isLogin.value = true;
                setLoginValue();
                Get.back();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred. Please try again.");
      verified.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      verified.value = false;
    }
  }

  Future<void> phoneAuthentication() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
        otpController.text = credential.smsCode ?? '';
      },
      verificationFailed: (e) {
        otpSent.value = false;
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "Recheck the number");
        } else {
          Get.snackbar("Error", "Try Again Later");
        }
      },
      codeSent: (verificationId, resendToken) {
        Get.snackbar("Success", "OTP sent Successfully");
        this.verificationId.value = verificationId;
        otpSent.value = true;
        verified.value = true;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  void backTo() {
    Get.offNamed(RoutesConstant.loginPage);
  }

  void formValidate() {
    var isValid = loginKey.currentState!.validate();
    if (!isValid) {
      isCorrectNumber.value = false;
      return;
    } else {
      isCorrectNumber.value = true;
      phoneAuthentication();
    }
  }


}
