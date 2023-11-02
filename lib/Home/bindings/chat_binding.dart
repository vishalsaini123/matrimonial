import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/chat_controller.dart';

import '../controllers/home_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
          () => ChatController(),fenix: true
    );
  }
}
