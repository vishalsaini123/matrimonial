
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/chat_controller.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/Home/views/VideoCall.dart';
import 'package:matrimonial_ai/Home/views/chat_screen.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/utils/SharePref.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_rtc_session.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:quickblox_sdk/webrtc/constants.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../widgets/primary_button.dart';



class ChatMessageView extends GetView<ChatController> {
  ChatMessageView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? textEditingController =  TextEditingController();


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Color(0xff101828)),
            onPressed: () {
              Get.delete<ChatController>();
              Get.back();
              },
          ),
          title: ListTile(
            contentPadding: EdgeInsets.only(left: -20),
            leading: Image.asset("assets/images/chat_dummy.png",height: 50,width: 50,),
            title: const Text("Siliva",style: TextStyle(fontFamily: 'mulish',fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
            subtitle: const Text("Active Now",style: TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),

          ),
          actions:  [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));

            }, icon: Image.asset("assets/images/call.png")),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VideoCall()));
              }, icon: Image.asset("assets/images/video.png")),
            ),

          ],),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Obx(() => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller:controller.scrollController,
                    itemCount: controller.messages.value.length,
                    itemBuilder: (context, index) =>  controller.senderId.value ==controller.messages.value[index]!.senderId?myMessage(controller.messages.value[index]!):friendMessage(controller.messages.value[index]!) ,

                  ),
                ),
              )),
               const Padding(
                 padding: EdgeInsets.symmetric(vertical: 10),
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
                          Expanded(
                           child: TextField(
                             controller: textEditingController,
                             onTap: (){


                               if (controller.scrollController.hasClients) {
                                 Future.delayed(const Duration(milliseconds: 500), () {
                                   if(controller.scrollController.positions.isNotEmpty){

                                     controller.scrollController?.jumpTo(controller.scrollController.position.maxScrollExtent);

                                   }
                                 });
                               }
                             },
                             decoration: const InputDecoration(
                               border: InputBorder.none,
                               hintText: "Type here..."),),
                         ),
                         IconButton(onPressed: (){
                           controller.sendMessage(textEditingController!.text);
                           textEditingController?.clear();

                         }, icon: Image.asset("assets/images/file.png")),

                       ],

                     ),
                   ),
                 ),
                 IconButton(onPressed: (){

                 }, icon: Image.asset("assets/images/camera.png")),
                 IconButton(onPressed: (){}, icon: Image.asset("assets/images/microphone.png")),


               ],)
            ],
          ),
        ),
      );


  }

  Widget friendMessage(QBMessage qbMessage) =>

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
              const Text("Silva test",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'mulish',fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
             Container(
               margin: const EdgeInsets.only(top: 10,bottom: 10),
               padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                 decoration: const BoxDecoration(color: Color(0xffF2F7FB),borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
                 child:  Text(qbMessage.body!,style: const TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),)),
             Text(controller.datetimeFormat(qbMessage.dateSent!),style: const TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF797C7B)),)
         ],),
          )
       ],


     );
  Widget myMessage(QBMessage qbMessage) =>

     Padding(
       padding: const EdgeInsets.only(top: 30,left: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            decoration: const BoxDecoration(color: Color(0xffC86486),borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
            child:  Text(qbMessage.body!,style: const TextStyle(fontFamily: 'mulish',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),)),
         Text(controller.datetimeFormat(qbMessage.dateSent!),style: const TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF797C7B)),)
         ],),
     );
}

