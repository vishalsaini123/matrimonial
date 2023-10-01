
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../widgets/primary_button.dart';



class ChatMessageView extends GetView<HomeController> {
  ChatMessageView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Color(0xff101828)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: ListTile(
            contentPadding: EdgeInsets.only(left: -20),
            leading: Image.asset("assets/images/chat_dummy.png",height: 50,width: 50,),
            title: const Text("Siliva",style: TextStyle(fontFamily: 'mulish',fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
            subtitle: const Text("Active Now",style: TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),

          ),
          actions:  [
            IconButton(onPressed: (){}, icon: Image.asset("assets/images/call.png")),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){}, icon: Image.asset("assets/images/video.png")),
            ),

          ],),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => index%2==0?friendMessage(index):myMessage(index),

                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10),
                 child: Divider(color: Color(0xffF3F6F6),height: 1.5,),
               ),
               Row(
                 mainAxisSize: MainAxisSize.max,
                 children: [
                IconButton(onPressed: (){}, icon: Image.asset("assets/images/attachment.png")),
                 Flexible(
                   child: Container(
                     padding: EdgeInsets.only(left: 10,right: 10),
                     decoration: const BoxDecoration(
                         color: Color(0xffF3F6F6),
                         borderRadius: BorderRadius.all(Radius.circular(12))),

                     child: Row(
                       children: [
                         const Expanded(
                           child: TextField(decoration: InputDecoration(
                               border: InputBorder.none,
                               hintText: "Type here..."),),
                         ),
                         IconButton(onPressed: (){}, icon: Image.asset("assets/images/file.png")),

                       ],

                     ),
                   ),
                 ),
                 IconButton(onPressed: (){}, icon: Image.asset("assets/images/camera.png")),
                 IconButton(onPressed: (){}, icon: Image.asset("assets/images/microphone.png")),


               ],)
            ],
          ),
        ),
      );


  }
  Widget friendMessage(int index) =>

     Row(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [

         Padding(
           padding: const EdgeInsets.only(bottom: 40),
           child: Image.asset("assets/images/chat_dummy.png",height: 50,width: 50,),
         ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 20),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
             const Text("Jhon Abraham",style: TextStyle(fontFamily: 'mulish',fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
             Container(
               margin: EdgeInsets.only(top: 10,bottom: 10),
               padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                 decoration: const BoxDecoration(color: Color(0xffF2F7FB),borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
                 child: const Text("How r u ?",style: TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),)),
             Text("11:30 pm",style: TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF797C7B)),)
         ],),
          )
       ],


     );
  Widget myMessage(int index) =>

     Padding(
       padding: const EdgeInsets.only(top: 30,left: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            decoration: const BoxDecoration(color: Color(0xffC86486),borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
            child: const Text("How r u ?",style: TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),)),
        Text("11:30 pm",style: TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF797C7B)),)
         ],),
     );
}

