
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_passordform_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/outline_loginbutton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../routes/app_pages.dart';
import '../../widgets/primary_button.dart';



class SignUpCompleteView extends GetView<SignUpController> {
  SignUpCompleteView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(child: Image.asset('assets/images/signupcomplete.png',fit: BoxFit.contain,)),




              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text('Wooahh!! Your sign up is successful. \n\nLet’s set up your profile to find your soulmate!',textAlign: TextAlign.center,style: TextStyle(color: Color(0xff000000) ,fontSize: 22,fontWeight: FontWeight.w600),),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: PrimaryButton(text: "Register",onPressed: (){
                  Get.toNamed(Routes.signup1);
                },),
              ),

            ],

          ),
        )
    );
  }

}
