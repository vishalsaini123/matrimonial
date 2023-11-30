import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/model/PreferenceModel.dart';
import 'package:matrimonial_ai/model/RegiseterVerifyOtpModel.dart';
import 'package:matrimonial_ai/model/RegisterApiResponse.dart';
import 'package:matrimonial_ai/model/RegisterModel.dart';
import 'package:matrimonial_ai/utils/snackbar_utils.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../model/GetEnvironmentModel.dart';
import '../../model/Religion.dart';
import '../../model/SearchModel.dart';
import '../../routes/app_pages.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import 'package:dio/dio.dart' as dio;

import '../../utils/SharePref.dart';

class SignUpController extends GetxController {
  RxList<ReligionModel> religiousList  = <ReligionModel>[].obs;
  RxList<ReligionModel> expectationList  = <ReligionModel>[].obs;
  RxBool isVisible = false.obs;
  RxString mobileNumber = ''.obs;
  Rx<File?>  imageFile = Rx<File?>(null);
  Rx<File?> imageFile1 = Rx<File?>(null);
  Rx<File?> imageFile2 = Rx<File?>(null);
  Rx<File?> imageFile3 = Rx<File?>(null);
  RxString name = ''.obs;
  RxString monthlyIncome = ''.obs;
  RxString age = ''.obs;
  RxDouble timerValue = 0.0.obs;
  RxString? cmvalue = 'CM'.obs;
  RxString? kgvalue = 'Kg'.obs;
  RxString? selectedHighEdu = "High School".obs;
  RxDouble? linearValue = 0.0.obs;
  String? pass;
  String? email;
  RxList<File> imageList = RxList<File>([]);
  final count = 0.obs;
  final HttpService _httpService = Get.find<HttpServiceImpl>();
  RxBool showPassowrd =  true.obs;
  Rx<GetEnvironmentModel> environmentVariables = GetEnvironmentModel().obs;
  Rx<RegisterApiResponse> registerApiResponse = RegisterApiResponse().obs;
  RxDouble pageprogress = 0.0.obs;
  RxInt profilepageprogress = 0.obs;
  RxInt genderpageprogress = 0.obs;

  double test = 0.0;
  var isCheck = false.obs;
  var isDataLoading = false.obs;
  var hasSearchData = false.obs;
  var isEnvLoading = false.obs;


  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
           CircularProgressIndicator(color: AppColors.primary,),
          Container(margin: const EdgeInsets.only(left: 7),child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Loading...",style: TextStyle(color: AppColors.primary,fontSize: 16,fontFamily: 'outfit'), ),
          )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  void timer(){
     Countdown(
      seconds: 60,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: const Duration(milliseconds: 1000),
      onFinished: () {

        print('Timer is done!');
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    religiousList.add(ReligionModel(name: "Any",value: true));
    religiousList.add(ReligionModel(name: "American",value: false));

    expectationList.add(ReligionModel(name: "Test 1",value: true));
    expectationList.add(ReligionModel(name: "Test 2",value: false));
    expectationList.add(ReligionModel(name: "Test 3",value: false));
    expectationList.add(ReligionModel(name: "Test 4",value: false));
    expectationList.add(ReligionModel(name: "Test 5",value: false));
    expectationList.add(ReligionModel(name: "Test 6",value: false));
    timer();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  Future<File?> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      File imagePath = File(pickedFile.path);
      print(imagePath.path);
      return imagePath;
    } else {
      return null;

    }
  }
  void signUp(String mobile) async {

    FocusManager.instance.primaryFocus?.unfocus();

    if(mobile.isEmpty){
      SnackBarUtils.showMsg("Please enter email address or mobile number");
      return;
    }

    else{

      try{
        isDataLoading(true);
        hasSearchData(true);
        showLoaderDialog(Get.context!);
        dio.Response? response =
        await _httpService.postRequest("sendOtpRegister",data: {
          "mobile" : mobile,
          "user_type" : "user"
        }
        );
        if (null != response) {

          print(response.data);
          Get.back();
          isDataLoading(false);
          if (response.statusCode == 200) {

            mobileNumber(mobile);
            registerApiResponse.value = RegisterApiResponse.fromJson(response.data);
            Get.toNamed(Routes.signupVerify,arguments: registerApiResponse.value.data?.otp);




          }
        }
      }
      catch(ex){

        isDataLoading(false);
        hasSearchData(true);
        Get.back();
        print(ex.toString());

      }

    }





  }

  void registerVerifyOTP(String? otp) async {
    FocusManager.instance.primaryFocus?.unfocus();


    if(otp!.isEmpty){
      SnackBarUtils.showMsg("Please enter Otp");
      return;
    }

    else{
 showLoaderDialog(Get.context!);
      try{
        isDataLoading(true);
        hasSearchData(true);
        dio.Response? response =
        await _httpService.postRequest("registerVerifyOtp",data: {
          "mobile" : mobileNumber.value,
          "otp" : otp
        }
        );
        print(response!.data!.toString());
        Get.back();
        if (null != response) {

          print(response.data);
          isDataLoading(false);
          if (response.statusCode == 200) {

            RegisterVerifyOtpModel model = RegisterVerifyOtpModel.fromJson(response.data);
            if(model.status ==200)
              {
                Get.toNamed(Routes.REGISTERCOMPLETE);
              }
            SnackBarUtils.showMsg(model.data.message);




          }
        }
      }
      catch(ex){
        Get.back();
        isDataLoading(false);
        hasSearchData(true);

        print(ex.toString());

      }

    }





  }

  void createQBUser(String email,String password,String fullName) async{



    try {
      isDataLoading(true);
      QBUser? user = await QB.users.createUser(email, password, fullName: fullName,tagList:fullName );
      debugPrint(user!.login);
      signInQbUser(email, password);

    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  void signInQbUser(String email, String password) async{


      try {
        isDataLoading(true);
        QBLoginResult result = await QB.auth.login(email, password);
        QBUser? qbUser = result.qbUser;
        QBSession? qbSession = result.qbSession;
        connect(qbUser!.id!, password);
        debugPrint(qbUser?.login);
        SharedPref().setQbId(qbUser!.id!);

      } on PlatformException catch (e) {
        isDataLoading(false);
        // some error occurred, look at the exception message for more details
      }

  }

  void connect(int userId,String password) async {
    try {
      await QB.chat.connect(userId, password);
      isDataLoading(false);
      Get.toNamed(Routes.profileComplete);

    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }
  void registerPreferences(String gender,String religion,String occupation,String nativePlace,
      String complexity,List<String> expectations) async {
    FocusManager.instance.primaryFocus?.unfocus();

      try{
        isDataLoading(true);
        hasSearchData(true);
        dio.Response? response =
        await _httpService.postRequest("registerPreferences",data: {
          "mobile" : "7054243647",
          "gender" : gender,
          "religous_believe" : religion,
          "occupation" : occupation,
          "native_place" : nativePlace,
          "complexity" : complexity,
          "expectations" : expectations
        }
        );
        print(response!.data!.toString());
        if (null != response) {

          print(response.data);
          isDataLoading(false);
          if (response.statusCode == 200) {

            PreferenceModel model = PreferenceModel.fromJson(response.data);
            if(model.status ==200)
              {
                Get.offAllNamed(Routes.HOME);
              }
            SnackBarUtils.showMsg(model.message);




          }
        }
      }
      catch(ex){

        isDataLoading(false);
        hasSearchData(true);

        print(ex.toString());

      }







  }
  Future<dio.FormData> createFormData() async {
    return dio.FormData.fromMap({
      'name': 'dio',
      'date': DateTime.now().toIso8601String(),
      'file': await dio.MultipartFile.fromFile('./text.txt',filename: 'upload.txt'),
    });
  }

  void registerComplete(String? firstName,String lastName,String password,String gender,
      String age,String nativePlace,String collegeName,String workPlace,String jobTitle,String monthlyIncome,
      String religion,String height,String weight,String complexity) async {
    FocusManager.instance.primaryFocus?.unfocus();


    if(imageList.length<2){
      SnackBarUtils.showMsg("Please select at least two images");
      return;
    }



    else{

  showLoaderDialog(Get.context!);
      try{
        isDataLoading(true);
        hasSearchData(true);
        List<dio.MultipartFile> multipartImageList =  <dio.MultipartFile>[];

        for(File file in imageList)
        {
          String fileName = file.path.split('/').last;
          var multi =  await dio.MultipartFile.fromFile(file.path,contentType:  MediaType('image', 'jpg'),filename: fileName);
          multipartImageList.add(multi);
        }

        final formdata = dio.FormData.fromMap({
          "mobile" : mobileNumber.value,
          "first_name" : firstName,
          "last_name" : lastName,
          "password" : password,
          "email" : "test1@gmail.com",
          "gender" : gender,
          "age" : age,
          "native_place" : nativePlace,
          "profile" : multipartImageList,
          "education" : selectedHighEdu!.value,
          "college_name" : collegeName,
          "work_place" : workPlace,
          "job_tittle" : jobTitle,
          "monthly_income" : monthlyIncome,
          "religous_believe" : religion,
          "height" : height,
          "weight" : weight,
          "complexity" : complexity,

        });

        dio.Response? response =
        await _httpService.postRequestWithFormData("registercomplete",data: formdata
        );

        if (null != response) {

          print(response.data);
          isDataLoading(false);

          if (response.statusCode == 200) {

            RegisterModel model = RegisterModel.fromJson(response.data);
            if(model.status ==200)
              {
                createQBUser(mobileNumber.value, password, "$firstName $lastName");

              }
            SnackBarUtils.showMsg(model.message);
            Get.back();

          }
        }
      }
      catch(ex){
        Get.back();
        isDataLoading(false);
        hasSearchData(true);

        print(ex.toString());

      }

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

  void calculateAge(DateTime today, DateTime dob) {
    final year = today.year - dob.year;
    final mth = today.month - dob.month;
    final days = today.day - dob.day;
    if(mth < 0){
      /// negative month means it's still upcoming
      print('you buns is ${year-1}');
      print('turning $year in ${mth.abs()} months and $days days');
      age("${year-1}");
    }
    else {
      print('your next bday is ${12-mth}months and ${28 -days} days away');
    }
  }


}
