import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

import 'core/app_binding.dart';
import 'data/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  String appId = "102214";
  String authKey = "ak_FGJdg6T7QEsWC3P";
  String authSecret = "as_5CxQgx2sgRPuDPT";
  String accountKey = "ack_egBTsHfS8huyJhGEVKJE";



  try {
    await QB.settings.init(appId, authKey, authSecret, accountKey);
    await QB.settings.enableAutoReconnect(true);
    await QB.webrtc.init();
  } on PlatformException catch (e) {
    debugPrint(e.message);
  }

  runApp(


    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.appTheme,
      initialBinding: AppBinding(),
    ),
  );
}


