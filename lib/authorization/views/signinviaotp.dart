
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_passordform_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/outline_loginbutton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../routes/app_pages.dart';
import '../../widgets/primary_button.dart';
import '../controllers/auth_controller.dart';



class SigninViaOtpView extends GetView<AuthController> {
  SigninViaOtpView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff101828)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Center(child: Text('Matrimonial.ai',style: TextStyle(color: Color(0xff7F4458),fontFamily: 'margarine' ,fontSize: 23,fontWeight: FontWeight.w500),)),),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign in via OTP',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              const SizedBox(height: 10,),
              const AppTextFormField(hintText: 'Email or mobile number',showLabel: false,),

              const Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 40),
                  child: Text('OTP will be sent to your registered email/number.',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 12,fontWeight: FontWeight.w400),)
              ),

              PrimaryButton(text: "Sign In",onPressed: (){
                Get.toNamed(Routes.VERIFYPASSWORD);
              },),
              const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Text('OR',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),)
                ),
              ),
              OutlinedAppButton(text: 'Login via Password',onPressed: (){
                Get.toNamed(Routes.LOGIN);
              },),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: RichText(
                      text:
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap =(){},
                          children:  [
                            const TextSpan(text: 'Don’t have an account? ',style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'outfit')),
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap =(){
                                  Get.toNamed(Routes.REGISTER);
                                },
                                text: 'Register',style: TextStyle(color: Color(0xff106EDC),fontSize: 18,fontFamily: 'outfit'))
                          ])),
                ),
              )

            ],

          ),
        )
    );
  }

}
