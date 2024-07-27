import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railways_shiva/routes/routes_constant.dart';
import 'package:railways_shiva/core/globals.dart' as glb;

class PassengerListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isCheck = false.obs;
  RxList<DocumentSnapshot> documents = RxList<DocumentSnapshot>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void toAdd() {
    Get.toNamed(RoutesConstant.addPassenger);
  }

  void toEdit(DocumentSnapshot doc) {
    glb.passengerDoc.value =doc.id;
    Get.toNamed(RoutesConstant.updatePage);
  }

  void deleteDocument(DocumentSnapshot doc) async {
    try {
      await _firestore.collection("Passenger").doc(doc.id).delete();
      fetchData(); // Refresh data after deletion
      Get.snackbar("Deleted", "Document deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete document: $e");
    }
  }

  void updateCheckbox(DocumentSnapshot doc, bool? value) {
    if (value != null) {
      _firestore.collection("Passenger").doc(doc.id).update({'isChecked': value});
      fetchData();
    }
  }

  void fetchData() async {
    try {
      final snapshots = await _firestore.collection("Passenger").get();
      documents.assignAll(snapshots.docs);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data: $e");
    }
  }
}
