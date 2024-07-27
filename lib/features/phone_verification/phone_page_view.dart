import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'phone_page_controller.dart';

class PhonePageView extends GetView<PhonePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Obx(
                  () => SingleChildScrollView(
                child: Container(
                  height: !controller.otpSent.value ? 300 : 600,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.7),
                  child: Form(
                    key: controller.loginKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Enter your mobile number to receive an OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, color: Colors.grey[800]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: TextFormField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.number,
                            enabled: !controller.otpSent.value,
                            decoration: InputDecoration(
                              labelText: "Mobile Number",
                              hintText: "Enter Phone Number",
                              prefixText: "+91",
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: controller.validatePhone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4, right: 8.0, bottom: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.formValidate,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple),
                              child: const Text(
                                "Get OTP",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        if (controller.otpSent.value)
                          Column(
                            children: [
                              Text(
                                "Enter the Code Sent to your Number",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              InkWell(
                                onTap: controller.onEdit,
                                child: Text(
                                  "+91 ${controller.phoneController.text}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Obx(
                                    () => Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: PinFieldAutoFill(
                                    controller: controller.otpController,
                                    codeLength: 6,
                                    currentCode: controller.codeValue.value,
                                    decoration: BoxLooseDecoration(
                                      bgColorBuilder: FixedColorBuilder(Colors.green[800]!),
                                      strokeColorBuilder: FixedColorBuilder(Colors.green[800]!),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Obx(
                                    () => TextButton(
                                  onPressed: controller.flag.value
                                      ? controller.resendOtp
                                      : null,
                                  child: Text(
                                    controller.flag.value
                                        ? "Resend OTP"
                                        : "Time Remaining ${controller.counter.value} \n",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 4, right: 8.0, bottom: 16),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: controller.verifyOTP,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple),
                                    child: const Text(
                                      "Verify",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                    () => Text(
                                  controller.verified.value ? "" : "Wrong OTP",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
