
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/views/match.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../model/content.dart';
import '../../routes/app_pages.dart';


class HomeController extends GetxController {

  RxInt selectedItem = 1.obs;
  Rx<Color> statusbarcolor = Colors.white.obs;
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



  @override
  void onInit() {


    for (int i = 0; i < _names.length; i++) {
      swipeItems?.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            if(i==3){
              Get.to(MatchView());

            }
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    matchEngine = MatchEngine(swipeItems: swipeItems);
    super.onInit();

    debugPrint("on init called ");


  }


@override
  void onClose() {
    super.onClose();
  }



}
