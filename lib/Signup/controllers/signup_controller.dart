import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/GetEnvironmentModel.dart';
import '../../model/SearchModel.dart';
import '../../routes/app_pages.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import 'package:dio/dio.dart' as dio;

class SignUpController extends GetxController {
  RxString name = ''.obs;
  RxString? cmvalue = 'CM'.obs;
  RxString? kgvalue = 'Kg'.obs;
  RxDouble? linearValue = 0.0.obs;
  String? pass;
  String? email;
  final count = 0.obs;
  final HttpService _httpService = Get.find<HttpServiceImpl>();
  RxString url =  "".obs;
  RxBool showPassowrd =  true.obs;
  Rx<GetEnvironmentModel> environmentVariables = GetEnvironmentModel().obs;
  RxDouble pageprogress = 0.0.obs;
  RxInt profilepageprogress = 0.obs;
  RxInt genderpageprogress = 0.obs;

  double test = 0.0;
  var isCheck = false.obs;
  var isDataLoading = false.obs;
  var hasSearchData = false.obs;
  var isEnvLoading = false.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void authorize() async {

    print(environmentVariables.value.codeChallenge);
    try{
      isDataLoading(true);
      hasSearchData(true);
      dio.Response? response =
      await _httpService.postRequest("authorize",data: {
        "clientId" : "STG2-MYINFO-SELF-TEST",
        "scope" : environmentVariables.value.scope,
        "purpose_id" : "demonstration",
        "redirectUrl" : "http://localhost:3001/callback",
        "authApiUrl" : "https://test.api.myinfo.gov.sg/com/v4/authorize",
        "code_challenge" : environmentVariables.value.codeChallenge
      }
      );
      if (null != response) {

        print(response.data);
        isDataLoading(false);
        if (response.statusCode == 200) {
          hasSearchData(true);

          url.value = response.data.toString();
          url.refresh();




        }
      }
    }
    catch(ex){

      isDataLoading(false);
      hasSearchData(true);

      print(ex.toString());

    }



  }
  void getenv() async {

    try{
      isEnvLoading(true);

      dio.Response? response =
      await _httpService.getRequest("getEnv");
      if (null != response) {

        isEnvLoading(false);
        print(response.data);

        if (response.statusCode == 200) {

          environmentVariables.value = GetEnvironmentModel.fromJson(response.data);



        }
      }
    }
    catch(ex){

      isEnvLoading(false);

      print(ex.toString());

    }



  }


}
