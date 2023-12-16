
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/bindings/chat_binding.dart';
import 'package:matrimonial_ai/Home/bindings/home_binding.dart';
import 'package:matrimonial_ai/Home/views/ChatMessageView.dart';
import 'package:matrimonial_ai/Home/views/HomeView.dart';
import 'package:matrimonial_ai/Home/views/NotificationListView.dart';
import 'package:matrimonial_ai/Signup/bindings/signup_binding.dart';
import 'package:matrimonial_ai/Signup/views/genderpreference.dart';
import 'package:matrimonial_ai/Signup/views/profilecomplete.dart';
import 'package:matrimonial_ai/Signup/views/signup.dart';
import 'package:matrimonial_ai/Signup/views/signup1.dart';
import 'package:matrimonial_ai/Signup/views/signup_verify_password.dart';
import 'package:matrimonial_ai/Signup/views/signupcomplete.dart';
import 'package:matrimonial_ai/authorization/views/forgot_password.dart';
import 'package:matrimonial_ai/authorization/views/login.dart';
import 'package:matrimonial_ai/authorization/views/signinviaotp.dart';
import 'package:matrimonial_ai/authorization/views/verify_password.dart';
import 'package:matrimonial_ai/splash/sliderscreen.dart';

import '../authorization/bindings/auth_binding.dart';
import '../login/bindings/search_binding.dart';
import '../login/views/search_view.dart';




part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.auth;

  static final routes = [
    GetPage(
      name: _Paths.SEARCH,
      page: () =>  SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () =>  const SliderScreens(),
      binding: AuthBinding(),
    ),GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: AuthBinding(),
    ),GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () =>  ForgotPasswordView(),
      binding: AuthBinding(),
    ),GetPage(
      name: _Paths.VERIFY_PASSWORD,
      page: () =>  VerifyPasswordView(),
      binding: AuthBinding(),
    ),GetPage(
      name: _Paths.SIGNINVIAOTP,
      page: () =>  SigninViaOtpView(),
      binding: AuthBinding(),
    ),GetPage(
      name: _Paths.REGISTER,
      page: () =>  SignUpView(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.SIGNUPVERIFY,
      page: () =>  SignUpVerifyPasswordView(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.REGISTERCOMPLETE,
      page: () =>  SignUpCompleteView(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.SIGNUP1,
      page: () =>  SignUp1(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.PROFILECOMPLETE,
      page: () =>  ProfileCompleteView(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.GENDERPREFERENCE,
      page: () =>  GenderPreference(),
      binding: SignupBinding(),
    ),GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),GetPage(
      name: _Paths.NOTIFCATIONLIST,
      page: () =>  NotificationListView(),
      binding: HomeBinding(),
    ),GetPage(
      name: _Paths.CHATMEESSAGES,
      page: () =>  ChatMessageView(),
      binding: ChatBinding(),
    ),
   /* GetPage(
      name: _Paths.hotelList,
      page: () =>  HotelList() ,
      binding: HotelListBinding(),
      children: [
        GetPage(
          name: _Paths.hotelDetail,
          page: () =>  HotelDetail() ,
          binding: HotelListBinding(),
        ),

      ]
    ),
    GetPage(
      name: _Paths.hotelRoomDetail,
      page: () =>  HotelRoomDetail() ,
      binding: HotelListBinding(),
    ),
    GetPage(
      name: _Paths.HOTELS,
      page: () => const HotelsView(),
      binding: HotelsBinding(),
      children: [

        GetPage(
          name: _Paths.SEARCH,
          page: () => const HotelsSearchView(),
          binding: HotelsSearchBinding(),
        ),

        GetPage(
          name: _Paths.DETAILS,
          page: () => const DetailsView(),
          binding: DetailsBinding(),
        ),

      ],
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.HEALTH,
      page: () => const HealthView(),
      binding: HealthBinding(),
    ),
    GetPage(
      name: _Paths.CARS,
      page: () => const CarsView(),
      binding: CarsBinding(),
    ),
    GetPage(
      name: _Paths.FLIGHTS,
      page: () => const FlightsView(),
      binding: FlightsBinding(),
      children: [
        GetPage(
          name: _Paths.SEARCH,
          page: () => const FlightsSearchView(),
          binding: FlightsSearchBinding(),
        ),
        GetPage(
          name: _Paths.TRIP_DETAILS,
          page: () => const TripDetailsView(),
          binding: TripDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => const IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FOOD,
      page: () => const FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),*/
  ];
}
