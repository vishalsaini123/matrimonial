import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../widgets/primary_button.dart';



class FavouriteView extends GetView<HomeController> {
  FavouriteView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

      return Column(

        children: [

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(" Check out your match list ",style: TextStyle(fontSize: 16,fontFamily: 'outfit',color: Colors.black.withOpacity(0.7)),),
          ),
            Padding(
            padding:  EdgeInsets.all(15.0),
            child: Row(
                children: <Widget>[
                  const Expanded(

                      child: Divider(height: 1,color: Colors.grey,)
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(" Today ",style: TextStyle(fontFamily: 'sk',color: Colors.black.withOpacity(0.7)),),
                  ),

                  const Expanded(
                      child: Divider(height: 1,color: Colors.grey,)
                  ),
                ]
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => buidImageCard(index),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 280,
                ),
              ),
            ),
          )
        ],
      );


  }
  Widget buidImageCard(int index) =>

      Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage("assets/images/home_dummy1.png"),
                fit: BoxFit.fill,
              ),
            ),
            child:   Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,

                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        // the size where the blurring starts
                        height: 40,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Jessica Parker, 23',style: TextStyle(color: Colors.white,fontFamily: 'sk' ,fontSize: 16,fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Image.asset("assets/images/like1.png",width: 40,height: 40,),
                      Image.asset("assets/images/dislike1.png",width: 40,height: 40,),

                    ],)
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}

