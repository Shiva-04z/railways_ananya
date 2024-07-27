import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'search_page_controller.dart';
import 'package:railways_shiva/core/globals.dart' as glb;

class SearchPageView extends GetView<SearchPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage("assets/img/irctc_logo.png"), height: 80, width: 80),
        title: const Text("Rail Connect"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button tap
            },
          ),
          Obx(
          ()=>InkWell(child:glb.isProfileUpdated.value? Image.network((glb.uploadedImages.value),height:50 ,width:50):Image.asset("assets/logo.jpg"),onTap: ()
              {
                controller.uploadImage();
              },),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Form(
                key: controller.loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              iconSize: 0,
                              decoration: const InputDecoration(
                                labelText: "From",
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                              ),
                              validator: (value)=>controller.fromValidator(value),
                              isDense: true,
                              onChanged: (value) => controller.dropDownSelectedFrom.value = value!,
                              items: controller.dropDownPlaceMenu,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_sharp),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              iconSize: 0,
                              decoration: const InputDecoration(
                                labelText: "To",
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                              ),
                              validator: (value)=>controller.toValidator(value),
                              isDense: true,
                              onChanged: (value) => controller.dropDownSelectedTo.value = value!,
                              items: controller.dropDownPlaceMenu,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: controller.dateController,
                          readOnly: true,
                          validator:(value)=> controller.dateValidator(value),
                          decoration: InputDecoration(
                            labelText: 'Travel Date',
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () => controller.selectDate(context),
                            ),
                          ),
                          onTap: () => controller.selectDate(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Class",
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                          ),
                          validator:(value) =>  controller.classValidator(value),
                          isDense: true,
                          onChanged: (value) => controller.dropDownSelectedClass.value = value!,
                          items: controller.dropDownClassMenu,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Quota",
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                          ),
                          validator: (value) => controller.quotaValidator(value),
                          isDense: true,
                          onChanged: (value) => controller.dropDownSelectedQuota.value = value!,
                          items: controller.dropDownQuotaMenu,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: controller.formValidate,
                          child: const Text("Search Train"),
                        ),
                      ),
                    ),
                    Center(
                      child: Obx(
                            () => controller.isPressed.value
                            ? Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("From : ${controller.dropDownSelectedFromUpdate.value}"),
                                  Text("To : ${controller.dropDownSelectedToUpdate.value}"),
                                  Text("Travel Date : ${DateFormat('dd-MM-yyyy').format(controller.selectedDateUpdate.value)}"),
                                  Text("Class : ${controller.dropDownSelectedClassUpdate.value}"),
                                  Text("Quota : ${controller.dropDownSelectedQuotaUpdate.value}"),
                                ],
                              ),
                            ),
                          ),
                        )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
