import 'package:get/get.dart';
import 'package:railways_shiva/features/passenger_add_page/passenger_add_bindings.dart';
import 'package:railways_shiva/features/passenger_add_page/passenger_add_view.dart';
import 'package:railways_shiva/routes/routes_constant.dart';
import '../features/home_page/home_page_bindings.dart';
import '../features/home_page/home_page_view.dart';
import '../features/login_page/login_page_bindings.dart';
import '../features/login_page/login_page_view.dart';
import '../features/phone_verification/phone_page_bindings.dart';
import '../features/phone_verification/phone_page_view.dart';
import '../features/passenger_list/passenger_list_page_bindings.dart';
import '../features/passenger_list/passenger_list_page_view.dart';
import '../features/signup_page/signup_page_bindings.dart';
import '../features/signup_page/signup_page_view.dart';
import '../features/splash_screen/splash_screen_bindings.dart';
import '../features/splash_screen/splash_screen_view.dart';
import '../features/edit_passenger/edit_passenger_bindings.dart';
import '../features/edit_passenger/edit_passenger_view.dart';
import '../features/train_search/search_page_bindings.dart';
import '../features/train_search/search_page_view.dart';
List<GetPage> getPages = [
  GetPage(
      name: RoutesConstant.splashScreen,
      page: () => SplashScreenView(),
      binding: SplashScreenBindings()),
  GetPage(
      name: RoutesConstant.loginPage,
      page: () => LoginPageView(),
      binding: LoginPageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.homePage,
      page: () => HomePageView(),
      binding: HomePageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.phoneVerify,
      page: () => PhonePageView(),
      binding: PhonePageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.signUpPage,
      page: () => SignUpPageView(),
      binding: SignUpPageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.searchPage,
      page: () => SearchPageView(),
      binding: SearchPageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.readPage,
      page: () => PassengersListView(),
      binding: PassengerListBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.addPassenger,
      page: () => AddPassengerView(),
      binding: AddPassengerBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: RoutesConstant.updatePage,
      page: () => EditPassengerView(),
      binding: UpdatePageBindings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300)),
];
