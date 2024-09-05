import 'package:food_delivery/src/screens/auth/login/login_view_model.dart';
import 'package:food_delivery/src/screens/auth/signup/signup_view_model.dart';
import 'package:food_delivery/src/screens/dashboard/offers/offers_view_model.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view_model.dart';
import 'package:get/get.dart';

import 'data/preference/preference_manager.dart';
import 'data/preference/preference_manager_impl.dart';
import 'screens/auth/mobile_auth/mobile_auth_view_model.dart';
import 'screens/auth/otp_auth/otp_auth_view_model.dart';
import 'screens/dashboard/cart/cart_view_model.dart';
import 'screens/dashboard/dashboard_view_model.dart';
import 'screens/dashboard/home/home_view_model.dart';
import 'screens/dashboard/home/tabs/appetizers/appetizers_view_model.dart';
import 'screens/dashboard/home/tabs/beverages/beverages_view_model.dart';
import 'screens/dashboard/home/tabs/desserts/desserts_view_model.dart';
import 'screens/dashboard/home/tabs/main_course/main_course_view_model.dart';
import 'screens/dashboard/home/tabs/side_dishes/side_dishes_view_model.dart';
import 'screens/dashboard/profile/profile_view_model.dart';
import 'screens/dashboard/saved/saved_view_model.dart';
import 'screens/product_detail/nutrition/nutrition_view_model.dart';
import 'screens/product_detail/product_detail_view_model.dart';
import 'screens/product_detail/reviews/reviews_view_model.dart';
import 'screens/search/search_view_model.dart';
import 'screens/splash/splash_view_model.dart';
import 'screens/view_all/view_all_view_model.dart';
import 'screens/welcome/welcome_view_model.dart';

class Injector implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );
    Get.lazyPut(
      () => SplashViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => WelcomeViewModel(),
      fenix: true,
    );
     Get.lazyPut(
      () => LoginViewModel(),
      fenix: true,
    );
     Get.lazyPut(
      () => SignupViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => MobileAuthViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => OtpAuthViewModel(),
      fenix: true,
    );
     Get.lazyPut(
      () => OnBoardingViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => DashboardViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => HomeViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => OffersViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => SavedViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => CartViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => ProfileViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => SearchViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => AppetizersViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => BeveragesViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => DessertsViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => MainCourseViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => SideDishesViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => ViewAllViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => ProductDetailViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => NutritionViewModel(),
      fenix: true,
    );
    Get.lazyPut(
      () => ReviewsViewModel(),
      fenix: true,
    );
  }
}
