import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/utils/SharePref.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import '../../model/GetEnvironmentModel.dart';
import '../../model/SearchModel.dart';
import '../../routes/app_pages.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import 'package:dio/dio.dart' as dio;

class AuthController extends GetxController {
  String? name;
  String? pass;
  String? email;
  final count = 0.obs;
  final HttpService _httpService = Get.find<HttpServiceImpl>();
  RxString url =  "".obs;
  RxBool showPassowrd =  true.obs;
  Rx<GetEnvironmentModel> environmentVariables = GetEnvironmentModel().obs;
  RxDouble pageprogress = 0.0.obs;

  double test = 0.0;
  var isDataLoading = false.obs;
  var hasSearchData = false.obs;
  var isEnvLoading = false.obs;



  @override
  void onInit() {
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

  void createQBUser() async{

    String email = "vs3@gmail.com";
    String password = "12345678";
    String fullName = "Mike";

    try {
      QBUser? user = await QB.users.createUser(email, password, fullName: fullName,tagList:fullName );
      debugPrint(user!.login);


    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  void signInQbUser(String email, String password) async{

    if(email.isEmpty){
      showMsg("Please enter email address");
      return;
    }
    else if(password.isEmpty){
      showMsg("Please enter password");
      return;
    }
    else if(password.length<8){
      showMsg("Password length should be greater than or equal to 8");
      return;
    }
    else{
      try {
        QBLoginResult result = await QB.auth.login(email, password);
        QBUser? qbUser = result.qbUser;
        QBSession? qbSession = result.qbSession;
       connect(qbUser!.id!, password);

        debugPrint(qbUser?.login);
        SharedPref().setQbId(qbUser!.id!);
        Get.offAllNamed(Routes.HOME);
      } on PlatformException catch (e) {
        // some error occurred, look at the exception message for more details
      }
    }


  }
  void createDialog() async {
    List<int> ids = [138975535, 138975537];
    String dialogName = "test dialog";
    int type = QBChatDialogTypes.CHAT;
    try {
      QBDialog? createdDialog = await QB.chat.createDialog(type,occupantsIds: ids,dialogName: dialogName);
      if(createdDialog != null) {
        String _dialogId = createdDialog.id!;
      }
    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }
  void connect(int userId,String password) async {
    try {
      await QB.chat.connect(userId, password);
    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }

  showMsg(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
