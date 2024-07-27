
import 'package:get/get.dart';
import 'package:railways_shiva/features/passenger_add_page/passenger_add_controller.dart';

class AddPassengerBindings extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => AddPassengerController());
  }

}