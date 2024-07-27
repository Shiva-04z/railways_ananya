import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:railways_shiva/features/login_page/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 55.0, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login to your account",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [
                Text(
                  "Hello, welcome back!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                Icon(Icons.front_hand_outlined, color: Colors.yellow)
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: Image(
                    image: AssetImage('assets/logo3.png'),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Form(
                key: controller.loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) => controller.emailValidator(value),
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          label: const Text("Email ID"),
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter your email",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(12, 12)),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Obx(
                        () => TextFormField(
                          validator: (value) =>
                              controller.passwordValidator(value),
                          controller: controller.passWordController,
                          obscureText: controller.isSet.value,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter password",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(12, 12)),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isSet.value =
                                      !controller.isSet.value;
                                },
                                icon: controller.isSet.value
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.password)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 220, bottom: 3.5),
                      child: TextButton(
                          onPressed: () {
                            controller.forgotPassword();
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.lightBlue.shade700, fontSize: 12),
                          )),
                    ),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.elevatedButton();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade900,
                          ),
                          child: const Text("Log in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Divider(
                            indent: 5,
                            endIndent: 5,
                          )),
                          Text("or Login with", style: TextStyle(fontSize: 12)),
                          Expanded(
                              child: Divider(
                            indent: 5,
                            endIndent: 5,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 25, right: 25, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 75,
                              height: 45,
                              child: InkWell(
                                  onTap: () {
                                    controller.facebookButton();
                                  },
                                  child: Center(
                                    child: ImageIcon(
                                      color: Colors.grey[850],
                                      size: 35,
                                      AssetImage("assets/icons/facebook.png"),
                                    ),
                                  ))),
                          SizedBox(
                              width: 75,
                              height: 45,
                              child: InkWell(
                                  onTap: () {
                                    controller.googleButton();
                                  },
                                  child: Center(
                                    child: ImageIcon(
                                      color: Colors.grey[850],
                                      size: 35,
                                      AssetImage("assets/icons/google.png"),
                                    ),
                                  ))),
                          SizedBox(
                              width: 75,
                              height: 45,
                              child: InkWell(
                                  onTap: () {
                                    controller.withPhone();
                                  },
                                  child: Center(
                                      child: ImageIcon(
                                    color: Colors.grey[850],
                                    size: 35,
                                    AssetImage("assets/icons/phone-call.png"),
                                  )))),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                              onTap: () {
                                controller.toRegister();
                              },
                              child: (const Text(" Sign Up",
                                  style: TextStyle(color: Colors.blue),
                                  textAlign: TextAlign.start)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
