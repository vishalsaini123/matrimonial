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



class ProfileView extends GetView<HomeController> {
  ProfileView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset("assets/images/chat_dummy.png",height: 80,width: 80,fit: BoxFit.fill,),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Arvita Sen',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 22,fontWeight: FontWeight.w400),),
                ),
                const Text('F, 26 yrs',style: TextStyle(color:  Color(0xFF797C7B),fontFamily: 'outfit' ,fontSize: 14,fontWeight: FontWeight.w400),),

              ],
            ),

            bottom: const PreferredSize(
            preferredSize: Size.fromHeight(180),
            child: TabBar(
                indicatorColor: Color(0xFF7F4458),
                indicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.all(8),
                labelPadding: EdgeInsets.all(8),
                indicatorWeight: 4,
                tabs: [
              Text('About',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 16,fontWeight: FontWeight.w400),),
              Text('Gallery',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 16,fontWeight: FontWeight.w400),),
              Text('Preferences',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 16,fontWeight: FontWeight.w400),),
            ]),
          ),),
          body:  TabBarView(

            children: [

              buidImageCard(),
              Image.asset("assets/images/profile_dummy1.png",height: 80,width: 80,fit: BoxFit.fill,),
           preferences()

            ],
          ),
        ),
      );


  }

  Widget preferences(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: GridView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          decoration: const BoxDecoration(
              color: Color(0xFFFCF5F9),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Center(child: Text("Loreum Lipsum",textAlign: TextAlign.center,style: TextStyle(color:  Color(0xFF797C7B),fontFamily: 'inter' ,fontSize: 14,fontWeight: FontWeight.w400),)),),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 15,
          childAspectRatio: 2.2
        ),
      ),
    );
  }

  Widget buidImageCard() {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidgets("Display Name"),
            textWidgets1("Arvita Sen"),
            textWidgets("Email Address"),
            textWidgets1("jhonabraham20@gmail.com"),
            textWidgets("Address"),
            textWidgets1("33 street west subidbazar,sylhet"),
            textWidgets("Phone Number"),
            textWidgets1("(320) 555-0104"),
            textWidgets("Qualification"),
            textWidgets1("Lorem ipsum"),
            textWidgets("Education"),
            textWidgets1("Lorem "),

          ],
        ),
      ),
    );
  }

  Widget textWidgets(String txt ){
    return  Text(txt,style: const TextStyle(color:  Color(0xFF797C7B),fontFamily: 'outfit' ,fontSize: 15,fontWeight: FontWeight.w400),);

  }
  Widget textWidgets1(String txt  ){
    return  Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 20),
      child: Text(txt,style: const TextStyle(color:  Colors.black,fontFamily: 'outfit' ,fontSize: 18,fontWeight: FontWeight.w400),),
    );

  }


}

