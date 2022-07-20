import 'package:get/get.dart';

import 'package:note/app/modules/create/bindings/create_binding.dart';
import 'package:note/app/modules/create/views/create_view.dart';
import 'package:note/app/modules/home/bindings/home_binding.dart';
import 'package:note/app/modules/home/views/home_view.dart';
import 'package:note/app/modules/login/bindings/login_binding.dart';
import 'package:note/app/modules/login/views/login_view.dart';
import 'package:note/app/modules/profile/bindings/profile_binding.dart';
import 'package:note/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE,
      page: () => CreateView(),
      binding: CreateBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
