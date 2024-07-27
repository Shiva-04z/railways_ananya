import 'package:get/get.dart';
import 'package:railways_shiva/features/signup_page/signup_page_controller.dart';

class SignUpPageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignUpPageController());
  }
}
