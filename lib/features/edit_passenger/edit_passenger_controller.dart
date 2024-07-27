import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:railways_shiva/core/globals.dart' as glb;

class EditPassengerController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  RxString groupValue = "".obs;
  RxString selected = "No Preference".obs;
  RxString name = "".obs;
  RxBool isValidating = false.obs;
  RxBool isfetched = false.obs;

  @override
 onInit()
  {
    super.onInit();
        fetchData();
  }





  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Passenger')
          .doc(glb.passengerDoc.value)
          .get();

      if (snapshot.exists) {
        groupValue.value = snapshot['Gender'];
        nameController.text = snapshot['Name'];
        selected.value=snapshot['Preference'];
        ageController.text = snapshot['Age'].toString();
        addressController.text = snapshot['Address'];
        mobileController.text = snapshot['Mobile'].toString();

      } else {
        Get.snackbar("Error", "Document does not exist");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

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

  String? addressValidator(value) {
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
  String? genderValidator() {
    if (groupValue.value.isEmpty) {
      return "Enter the Gender Value";
    } else {
      isValidating.value = false;
      return null;
    }
  }

  Future<void> editData() async {
    try {
      await firestore.collection("Passenger").doc(glb.passengerDoc.value).update({
        'Age': int.parse(ageController.text),
        'Gender': groupValue.value,
        'Address': addressController.text,
        'Mobile': int.parse(mobileController.text)
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
            const Text("Data Edited Successfully"),
            ElevatedButton(
              onPressed: () {
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
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void saveButton() {
    isValidating.value = true;
    String? genderError = genderValidator();
    if (formKey.currentState!.validate() && genderError == null) {
      editData();
    } else {
      Get.snackbar("Error", "Please fill all the fields correctly");
    }
  }
}
