import 'package:get/get.dart';
import 'package:railways_shiva/features/train_search/search_page_controller.dart';

class SearchPageBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
  }
  
}