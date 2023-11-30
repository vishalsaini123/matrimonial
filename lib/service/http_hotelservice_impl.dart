//import 'package:socialdeal/app/core/controller/user_controller.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as get_x;
//import 'package:get_storage/get_storage.dart';

import 'http_service.dart';

const baseURL = "https://sinpassapi.vercel.app/";

class HttpHotelServiceImpl implements HttpService {
  late Dio _dio;

  Map<String, String> get headers {
    //GetStorage storage = GetStorage();
    //String? authToken = storage.read(Cons.TOKEN);
    String? authToken;
    Map<String, String> header = {};
    header['Accept'] = "application/json";
    //header['Accept'] = "application/x-www-form-urlencoded";
    if (null != authToken) {
      header['Authorization'] = "Bearer $authToken";
    }
    return header;
  }

  HttpHotelServiceImpl() {
    init();
  }

  @override
  Future<void> init() async {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(minutes: 5),
      //5s
      receiveTimeout: const Duration(minutes: 5),
      contentType: "application/json",
      responseType: ResponseType.json,
    ));
    await initializeInterceptors();
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (
      DioError err,
      ErrorInterceptorHandler handler,
    ) {
      handler.next(err);
      if (null != err.response && err.response!.statusCode == 401) {
        //must be Unauthenticated,clear preference and  move to index
        //get_x.Get.find<UserController>().logout(callApi: false);
      }
    }, onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) {
      // Do something before request is sent
      // options.headers.addAll(headers);
      handler.next(options);
    }, onResponse: (
      Response response,
      ResponseInterceptorHandler handler,
    ) {
      handler.next(response);
    }));
  }

  @override
  Future<Response?> getRequest(String url) async {
    Response? response;
    try {
      response = await _dio.get(url);
    } on Exception catch (e) {
      print(e.toString());
    }
    return response;
  }

  @override
  Future<Response?> postRequestWithFormData(String url, {FormData? data}) async{
    Response? response;
    try {
      response = await (null != data
          ? _dio.post(url, data: jsonEncode(data))
          : _dio.post(url));
    } on Exception catch (e) {

      throw Exception(e);

    }
    return response;
  }

  @override
  Future<Response?> postRequest(String url,
      {Map<String, dynamic>? data}) async {
    print("hjhhjhjjhj");
    Response? response;
    try {
      response = await (null != data
          ? _dio.post(url, data: jsonEncode(data))
          : _dio.post(url));
    } on Exception catch (e) {
      print(e.toString());
    }
    return response;
  }

  @override
  Future<Response?> deleteRequest(String url) async {
    Response? response;
    try {
      response = await _dio.delete(url);
    } on Exception catch (e) {
      print(e.toString());
    }
    return response;
  }

  @override
  Future<Response?> patchRequest(String url, {FormData? data}) async {
    Response? response;
    try {
      response =
          await (null != data ? _dio.patch(url, data: data) : _dio.patch(url));
    } on Exception catch (e) {
      print(e.toString());
    }
    return response;
  }
}
