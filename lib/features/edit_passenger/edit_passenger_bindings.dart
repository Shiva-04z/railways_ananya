import 'package:get/get.dart';
import 'package:railways_shiva/features/edit_passenger/edit_passenger_controller.dart';

class UpdatePageBindings extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EditPassengerController());
  }
}
