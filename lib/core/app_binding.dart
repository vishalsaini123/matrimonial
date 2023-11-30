
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';

import '../service/http_hotelservice_impl.dart';
import '../service/http_service_impl.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HttpServiceImpl());
    Get.put(HttpHotelServiceImpl());



  }
}
