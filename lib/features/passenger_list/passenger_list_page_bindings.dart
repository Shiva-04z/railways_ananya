import 'package:get/get.dart';
import 'package:railways_shiva/features/passenger_list/passenger_list_page_controller.dart';

class PassengerListBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PassengerListController());
  }

}