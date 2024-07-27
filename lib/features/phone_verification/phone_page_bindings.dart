import 'package:get/get.dart';
import 'package:railways_shiva/features/phone_verification/phone_page_controller.dart';

class PhonePageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PhonePageController());
  }
}
