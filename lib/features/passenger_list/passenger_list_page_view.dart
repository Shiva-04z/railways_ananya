import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:railways_shiva/features/passenger_list/passenger_list_page_controller.dart';

class PassengersListView extends GetView<PassengerListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger Master List"),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              controller.toAdd();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Add Passenger",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.documents.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.documents.length,
            itemBuilder: (context, index) {
              var doc = controller.documents[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doc['Name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Checkbox(
                            value: doc['isChecked'],
                            onChanged: (value) {
                              controller.updateCheckbox(doc, value);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Gender : ${doc['Gender']}\nPreference : ${doc['Preference']}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Implement edit functionality
                            controller.toEdit(doc);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // Implement delete functionality
                            controller.deleteDocument(doc);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
