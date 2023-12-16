
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/views/match.dart';
import 'package:matrimonial_ai/model/HomeListingModel.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../data/colors.dart';
import '../../model/content.dart';
import '../../routes/app_pages.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import '../../utils/snackbar_utils.dart';
import 'package:dio/dio.dart' as dio;

class HomeController extends GetxController {

  RxInt selectedItem = 1.obs;
  var isDataLoading = false.obs;
  var hasSearchData = false.obs;

  final HttpService _httpService = Get.find<HttpServiceImpl>();
  Rx<Color> statusbarcolor = Colors.white.obs;
  Rx<HomeListingModel> homeListing = HomeListingModel().obs;
  final List<SwipeItem> swipeItems = <SwipeItem>[];
  MatchEngine? matchEngine;
  final List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];
  Widget loader() {
    return isDataLoading.value? Container(
      color: Colors.grey[200],
      width: 90.0,
      height: 90.0,
      child:  const Padding(padding: EdgeInsets.all(5.0),child: Center(child: CircularProgressIndicator())),
    ): Container();
  }
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

  @override
  void onInit() {
    super.onInit();
    
    Future.delayed(Duration.zero,(){
      getHomeListing();
      showLoaderDialog(Get.context!);
    });




    debugPrint("on init called ");
  }

  void getHomeListing() async {
    FocusManager.instance.primaryFocus?.unfocus();


      try{
        isDataLoading(true);

        dio.Response? response =
        await _httpService.getRequest("getHomeListing");
        print(response!.data!.toString());
        Future.delayed(const Duration(seconds: 1),(){
          Get.back();
        });
        if (null != response) {

          print(response.data);
          isDataLoading(false);
           hasSearchData(true);

          if (response.statusCode == 200) {

            HomeListingModel model = HomeListingModel.fromJson(response.data);

            if(model.status ==200)
            {
              homeListing(model);
              for (int i = 0; i < model!.data!.length; i++) {

                swipeItems?.add(SwipeItem(
                    content: Content(text: model.data![i].name),
                    likeAction: () {
                      if(i==3){
                        Get.to(MatchView());

                      }
                      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
                        content: Text("Liked ${model.data![i].name}"),
                        duration: const Duration(milliseconds: 500),
                      ));
                    },
                    nopeAction: () {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
                        content: Text("Nope ${model.data![i].name}"),
                        duration: const Duration(milliseconds: 500),
                      ));
                    },
                    superlikeAction: () {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
                        content: Text("Superliked ${model.data![i].name}"),
                        duration: const Duration(milliseconds: 500),
                      ));
                    },
                    onSlideUpdate: (SlideRegion? region) async {
                      print("Region $region");
                    }));
              }

              matchEngine = MatchEngine(swipeItems: swipeItems);
            }
            SnackBarUtils.showMsg(model.message!);




          }
        }
      }
      catch(ex){
        isDataLoading(false);
        hasSearchData(false);
        Get.back();
        print(ex.toString());

      }
  }


@override
  void onClose() {
    super.onClose();
  }



}
