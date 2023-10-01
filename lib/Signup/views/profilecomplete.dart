
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_passordform_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/outline_loginbutton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../widgets/primary_button.dart';



class ProfileCompleteView extends GetView<SignUpController> {
  ProfileCompleteView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(child: Image.asset('assets/images/profilecomplete.png',fit: BoxFit.contain,)),




              const Spacer(),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text('Your profile is \n complete!',textAlign: TextAlign.center,style: TextStyle(color: Color(0xff000000) ,fontSize: 22,fontWeight: FontWeight.w600),),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Select your partner preference to\n find the perfect match',textAlign: TextAlign.center,style: TextStyle(color: Color(0xff505050),fontSize: 19,fontFamily: "outfit",fontWeight: FontWeight.w400),),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: PrimaryButton(text: "Proceed",onPressed: (){

                  Get.toNamed(Routes.genderPreference);

                },),
              ),

            ],

          ),
        )
    );
  }

}
