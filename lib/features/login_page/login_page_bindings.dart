import 'package:get/get.dart';
import 'package:railways_shiva/features/login_page/login_page_controller.dart';

class LoginPageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginPageController());
  }
}
