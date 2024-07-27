
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_passenger_controller.dart';

class EditPassengerView extends GetView<EditPassengerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.saveButton,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      appBar: AppBar(title: Text("Edit Passenger Details")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: SizedBox(
                            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.nameController,
                     enabled: false,
                                          decoration: InputDecoration(
                                             border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                      ),
                    ),
                  ),
                  Text(
                    "Age",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.ageController,
                      decoration: InputDecoration(
                        hintText: "Enter Age",
                        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                      ),
                      validator: (value) => controller.ageValidator(value),
                    ),
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Obx(
                        () => Row(
                      children: [
                        Radio<String>(
                          value: "Male",
                          groupValue: controller.groupValue.value,
                          onChanged: (value) {
                            controller.groupValue.value = value!;
                          },
                        ),
                        Text("Male"),
                        Radio<String>(
                          value: "Female",
                          groupValue: controller.groupValue.value,
                          onChanged: (value) {
                            controller.groupValue.value = value!;
                          },
                        ),
                        Text("Female"),
                        Radio<String>(
                          value: "Other",
                          groupValue: controller.groupValue.value,
                          onChanged: (value) {
                            controller.groupValue.value = value!;
                          },
                        ),
                        Text("Other"),
                      ],
                    ),
                  ),
                  Obx(
                        () => controller.isValidating.value
                        ? Text(
                      "Please Check Value",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )
                        : Text(""),
                  ),
                  Text(
                    "Berth",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 160,
                      child: Obx(()=>DropdownButtonFormField(
                           value: controller.selected.value,
                          items: controller.dropDownMenu,
                          onChanged: null
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Address Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.addressController,
                      decoration: InputDecoration(
                        hintText: "Enter Address",
                        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                      ),
                      validator: (value) => controller.addressValidator(value),
                    ),
                  ),
                  Text(
                    "Mobile Number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.mobileController,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                      ),
                      validator: (value) => controller.mobileValidator(value),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
