import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';

import 'core/app_binding.dart';
import 'data/theme.dart';

void main() {

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


