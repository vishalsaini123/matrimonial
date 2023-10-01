import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../widgets/primary_button.dart';



class ChatListView extends GetView<HomeController> {
  ChatListView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

      return Column(

        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: AppTextFormField(prefixIcon: ImageIcon(AssetImage("assets/images/search.png")),hintText: "Search",showLabel: false,),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => buidImageCard(index),
               
              ),
            ),
          )
        ],
      );


  }
  Widget buidImageCard(int index) =>

     ListTile(
       onTap: (){Get.toNamed(Routes.chatMessage);},
       contentPadding: EdgeInsets.all(8),
       leading: Image.asset("assets/images/chat_dummy.png",),
       title: const Text("Siliva",style: TextStyle(fontFamily: 'roboto',fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
       subtitle: const Text("I’m not a hoarder but I really...",style: TextStyle(fontFamily: 'roboto',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
       trailing: const Padding(
         padding: EdgeInsets.only(top: 12),
         child: Text("11:30",style: TextStyle(fontFamily: 'roboto',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
       ),
     );
}

