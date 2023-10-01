
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../widgets/primary_button.dart';



class NotificationListView extends GetView<HomeController> {
  NotificationListView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff101828)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Notifications',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(child: Text('Clear All',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),)),
          ),
        ],),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => buidImageCard(index),

          ),
        ),
      );


  }
  Widget buidImageCard(int index) =>

     ListTile(
       isThreeLine: true,
       contentPadding: const EdgeInsets.all(8),
       leading: Image.asset("assets/images/notification_dummy.png",),
       title:  const Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [

         Text("5h ago",style: TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color:Color(0xFF6B6B6B),)),
         Padding(
           padding: EdgeInsets.symmetric(vertical: 10),
           child: Text("Hey, don’t forget to verify your email",style: TextStyle(fontFamily: 'mulish',fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
         ),

         ],
       ),
       subtitle: const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do...",style: TextStyle(fontFamily: 'mulish',fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF6B6B6B)),),

     );
}

