
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



class SignUpView extends GetView<SignUpController> {
  SignUpView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Center(child: Text('Matrimonial.ai',style: TextStyle(color: Color(0xff7F4458),fontFamily: 'margarine' ,fontSize: 23,fontWeight: FontWeight.w500),)),),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Register',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              const AppTextFormField(hintText: 'Email or mobile number',showLabel: false,),


              const SizedBox(height: 20,),
              PrimaryButton(text: "Register",onPressed: (){

                Get.toNamed(Routes.signupVerify);

              },),
              const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Text('OR',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),)
                ),
              ),
              OutlinedAppLoginButton(text: 'Continue with Face',onPressed: (){},),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: RichText(
                      text:
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap =(){},
                          children:  [
                            const TextSpan(text: 'Already have an account? ',style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'outfit')),
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap =(){
                                  Get.toNamed(Routes.LOGIN);
                                },
                                text: 'Sign in',style: TextStyle(color: Color(0xff106EDC),fontSize: 18,fontFamily: 'outfit'))
                          ])),
                ),
              )

            ],

          ),
        )
    );
  }

}
