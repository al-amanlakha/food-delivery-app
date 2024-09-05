import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/auth/login/login_view.dart';
import 'package:food_delivery/src/screens/auth/signup/signup_view.dart';
import 'package:food_delivery/src/screens/dashboard/offers/offers_view.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view.dart';
import 'package:get/get.dart';


import '../constants/app_values.dart';
import '../screens/auth/mobile_auth/mobile_auth_view.dart';
import '../screens/auth/otp_auth/otp_auth_view.dart';
import '../screens/dashboard/cart/cart_view.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/dashboard/home/home_view.dart';
import '../screens/dashboard/profile/profile_view.dart';
import '../screens/dashboard/saved/saved_view.dart';
import '../screens/filter/filter_view.dart';
import '../screens/product_detail/product_detail_view.dart';
import '../screens/search/search_view.dart';
import '../screens/splash/splash_view.dart';
import '../screens/view_all/view_all.dart';
import '../screens/welcome/welcome_view.dart';

class AppRoutes {
  AppRoutes._();

  static final AppRoutes _instance = AppRoutes._();

  static AppRoutes get instance => _instance;

  final List<GetPage> pages = [
    GetPage(
      name: SplashView.id,
      page: () => const SplashView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
  GetPage(
      name: WelcomeView.id,
      page: () => const WelcomeView(),
      curve: Curves.ease,
    transition: Transition.cupertino,
    transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: LoginView.id,
      page: () => const LoginView(),
      curve: Curves.ease,
    transition: Transition.cupertino,
    transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: SignupView.id,
      page: () => const SignupView(),
      curve: Curves.ease,
    transition: Transition.cupertino,
    transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: MobileAuthView.id,
      page: () => const MobileAuthView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
  GetPage(
      name: OtpAuthView.id,
      page: () => const OtpAuthView(),
      curve: Curves.ease,
    transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: OnBoardingView.id,
      page: () => const OnBoardingView(),
      curve: Curves.ease,
    transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: DashboardView.id,
      page: () => const DashboardView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: ProductDetailView.id,
      page: () => const ProductDetailView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: HomeView.id,
      page: () => const HomeView(),
      transition: Transition.fade,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: OffersView.id,
      page: () => const OffersView(),
      transition: Transition.fade,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: SearchView.id,
      page: () => const SearchView(),
      transition: Transition.fade,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: SavedView.id,
      page: () => const SavedView(),
      transition: Transition.fade,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: CartView.id,
      page: () => const CartView(),
      transition: Transition.fade,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
    GetPage(
      name: ProfileView.id,
      page: () => const ProfileView(),
      transition: Transition.fade,
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
  GetPage(
      name: ViewAll.id,
      page: () => ViewAll(),
      curve: Curves.ease,
      transition: Transition.cupertino,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
  GetPage(
    name: FilterView.id,
    fullscreenDialog: true,
    page: () => const FilterView(),
    curve: Curves.linear,
    transition: Transition.cupertinoDialog,  // Specify the transition type here
      transitionDuration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    ),
  ];

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final GetPage? page = pages.firstWhereOrNull((p) => p.name == settings.name);
    if (page != null) {
      return GetPageRoute(
        routeName: settings.name!,
        settings: settings,

        page: page.page,
        transition: page.transition,
        transitionDuration: page.transitionDuration!,
      );
    }
    return null;
  }
}
