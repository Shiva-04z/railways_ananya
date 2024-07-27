import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_constant.dart';

class AddPassengerController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  RxString groupValue = "".obs;
  RxString selected = "".obs;
  RxBool isValidating = false.obs;
  List<DropdownMenuItem<String>> dropDownMenu = [
    for (var preference in [
      "No Preference",
      "Lower",
      "Middle",
      "Upper",
      "Side Lower",
      "Side Upper"
    ])
      DropdownMenuItem(value: preference, child: Text(preference))
  ];

  nameValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter Name";
    }
    return null;
  }


  ageValidator(value) {
    if (value.isEmpty) {
      return "Please enter Age";
    }
    if (int.tryParse(value) == null) {
      return "Please enter a valid Age";

    }
    if(int.parse(value)>180||int.parse(value)<0)
    {
      return "Please enter a valid Age";
    }
    return null;
  }


  addressValidator(value) {
    if (value.isEmpty) {
      return "Please enter Address";
    }
    return null;
  }

 mobileValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter Mobile Number";
    }
    else
    {
      try {
        int.parse(value);
      }
      catch(e){
        return "Please Enter Number";
   }
      if(value.length==10)
      {
        return null;

      }
      else
      {
        return "Enter number in 10 digits ";
      }
    }
    // Additional validation logic can be added here

  }

  genderValidator() {
    if (groupValue.value == "") {
      return "Enter the Gender Value";
    } else {
      isValidating.value = false;
      return null;
    }
  }

  berthValidator(value) {
    if (value == null) {
      return "Please select Berth Preference";
    }
    return null;
  }

  Future<void> addData() async {
    try {
      await FirebaseFirestore.instance.collection("Passenger").add({
        'Name': nameController.text,
        'Age': int.parse(ageController.text),
        'Address': addressController.text,
        'Gender': groupValue.value,
        'Preference': selected.value,
        'Mobile': int.parse(mobileController.text),
        'isChecked': false
      });
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
            const Text("Data Saved Successfully"),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(RoutesConstant.readPage);
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
    } catch (e) {
      Get.snackbar("", e.toString());
    }
  }

  void saveButton() {
    isValidating.value = true;
    genderValidator();
    if (formKey.currentState!.validate() && !isValidating.value) {
      addData();
    } else {
      Get.snackbar("Error", "Please fill all the fields correctly");
    }
  }
}
