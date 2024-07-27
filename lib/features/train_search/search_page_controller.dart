import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:railways_shiva/core/globals.dart' as glb;
import 'package:shared_preferences/shared_preferences.dart';

class SearchPageController extends GetxController {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  RxString str = "".obs;
  RxBool isDuplicate = false.obs;
  RxBool isUpload = false.obs;
  RxBool isPressed = false.obs;
  RxString dropDownSelectedFrom = "".obs;
  RxString dropDownSelectedTo = "".obs;
  RxString dropDownSelectedClass = RxString("Sleeper");
  RxString dropDownSelectedQuota = RxString("General");
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dropDownSelectedFromUpdate = RxString("No Value");
  RxString dropDownSelectedToUpdate = RxString("No Value");
  RxString dropDownSelectedClassUpdate = RxString("Sleeper");
  RxString dropDownSelectedQuotaUpdate = RxString("General");
  Rx<DateTime> selectedDateUpdate = DateTime.now().obs;


  Future <void> onReady ()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    glb.isProfileUpdated.value = prefs.getBool("isProfileUpdated")!;
    glb.uploadedImages.value= prefs.getString("Profile")!;

  }

  void profileCheck()async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isProfileUpdated", glb.isProfileUpdated.value);
    prefs.setString("Profile", glb.uploadedImages.value);

  }

  uploadToFirebase(image)async {
    try{


      Reference sr = FirebaseStorage.instance.ref().child('Images/${DateTime.now().millisecondsSinceEpoch}');
      await sr.putFile(image).whenComplete(() async =>
      {

        glb.uploadedImages.value = await sr.getDownloadURL(),
        glb.isProfileUpdated.value = true,
        profileCheck(),
          Get.snackbar("", "Sucessfully updated")}
      );


    }catch(e) {
      Get.snackbar("",e.toString());
    }
  }

  uploadImage()async
  {
    final ImagePicker imagePicker= ImagePicker();
    XFile ? res =(await imagePicker.pickImage(source: ImageSource.gallery));
    if(res !=null)
    {
      uploadToFirebase(File(res.path));
    }
  }
fromValidator( value) {
    if (value==null || value == dropDownSelectedTo.value) {
      return "Please Check Source";
    }
    return null;
  }

toValidator(value) {
    if (value==null || value == dropDownSelectedFrom.value) {
      return "Please Check Destination";
    }
    return null;
  }

dateValidator( value) {
    if (value!.isEmpty) {
      return "Please enter the Date";
    }
    return null;
  }
  classValidator(value) {

    if (value==null) {

      return "Please select the Class";
    }
    return null;
  }
 quotaValidator( value) {
    if (value==null) {
      return "Please select the Quota";
    }
    return null;
  }

  List<DropdownMenuItem<String>> dropDownPlaceMenu = [
    for (var location in ["Gwalior", "Bhopal", "Indore", "Jaipur", "Jabalpur", "Jhansi"])
      DropdownMenuItem(value: location, child: Text(location))
  ];


  List<DropdownMenuItem<String>> dropDownClassMenu = [
    for (var trainClass in ["Sleeper", "AC 3 Tier", "AC 2 Tier", "First Class"])
      DropdownMenuItem(value: trainClass, child: Text(trainClass, style: TextStyle(fontWeight: FontWeight.bold)))
  ];

  List<DropdownMenuItem<String>> dropDownQuotaMenu = [
    for (var quota in ["General", "Tatkal", "Ladies", "Senior Citizen"])
      DropdownMenuItem(value: quota, child: Text(quota, style: TextStyle(fontWeight: FontWeight.bold)))
  ];

  void uploadButton() {
    if (isPressed.value) {
      if (!isUpload.value) {
        addData();
        isUpload.value = true;
      } else {
        Get.snackbar("", "Ticket Already in Firebase");
      }
    } else {
      Get.snackbar("", "Ticket Not Generated");
    }
  }

  Future<void> addData() async {
    try {
      await FirebaseFirestore.instance.collection("Train").add({
        'From': dropDownSelectedFromUpdate.value,
        'To': dropDownSelectedToUpdate.value,
        'Travel Date': selectedDateUpdate.value,
        'Class': dropDownSelectedClassUpdate.value,
        'Quota': dropDownSelectedQuotaUpdate.value,
      });
      Get.snackbar("", "Data added successfully");
    } catch (e) {
      Get.snackbar("", e.toString());
    }
  }

  void checkValue() {
    isDuplicate.value = selectedDateUpdate.value == selectedDate.value &&
        dropDownSelectedFromUpdate.value == dropDownSelectedFrom.value &&
        dropDownSelectedClassUpdate.value == dropDownSelectedClass.value &&
        dropDownSelectedToUpdate.value == dropDownSelectedTo.value &&
        dropDownSelectedQuotaUpdate.value == dropDownSelectedQuota.value;
  }

  Future<void> formValidate() async {
    if (loginKey.currentState!.validate()) {
      checkValue();
      if (!isDuplicate.value) {
        selectedDateUpdate.value = selectedDate.value;
        dropDownSelectedFromUpdate.value = dropDownSelectedFrom.value;
        dropDownSelectedClassUpdate.value = dropDownSelectedClass.value;
        dropDownSelectedToUpdate.value = dropDownSelectedTo.value;
        dropDownSelectedQuotaUpdate.value = dropDownSelectedQuota.value;
        isPressed.value = true;
        isDuplicate.value = true;
        isUpload.value = false;
        Get.snackbar("Ticket Generated Successfully", "Now you can update it to Firebase");
      } else {
        Get.snackbar("", "Duplicate Ticket");
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate); // Format as needed
    }
  }
}
