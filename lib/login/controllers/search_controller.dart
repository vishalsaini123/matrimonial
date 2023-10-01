import 'package:get/get.dart';

import '../../authorization/controllers/auth_controller.dart';
import '../../model/SearchModel.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import 'package:dio/dio.dart' as dio;

class SearchSingPassController extends GetxController {
  String? name;
  String? pass;
  String? email;
  final count = 0.obs;
  final HttpService _httpService = Get.find<HttpServiceImpl>();
  Rx<SearchModel> searchomdel =  SearchModel().obs;
  var isDataLoading = false.obs;
  var hasSearchData = false.obs;

  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //searchFlight();

  }

  @override
  void onReady() {
    super.onReady();
    String code = Get.arguments as String;

    print(authController.environmentVariables.value.codeVerifier);
    personData(code, authController.environmentVariables.value.codeVerifier!);
  }
  void personData(String authCode,String codeVerifier) async {

    try{
      isDataLoading(true);
      hasSearchData(true);
      dio.Response? response =
      await _httpService.postRequest("getpersondata",data: {
        "authCode" : authCode,
        "codeVerifier" : codeVerifier
      }
      );

      if (null != response) {

        print(response.data);
        isDataLoading(false);
        if (response.statusCode == 200) {
          hasSearchData(true);

          searchomdel.value = SearchModel.fromJson(response.data);


        }
      }
    }
    catch(ex){
      print(ex.toString());
      searchomdel.value = SearchModel();
      isDataLoading(false);
      hasSearchData(true);



    }



  }
}
