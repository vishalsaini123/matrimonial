
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

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



class VerifyPasswordView extends GetView<AuthController> {
  VerifyPasswordView({Key? key}) : super(key: key);

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
                child: Text('Enter OTP sent to +1-675****123',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 43,
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: const Color(0xFF512DA8),
                  fieldWidth: 43,
                  enabledBorderColor: Colors.grey.shade300,
                  focusedBorderColor: Colors.grey.shade300,

                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        }
                    );
                  }, // end onSubmit
                ),
              ),

              const Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 40),
                  child: Text('Didn’t receive the OTP? Retry in 00:11',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 12,fontWeight: FontWeight.w400),)
              ),

              PrimaryButton(text: "Verify",onPressed: (){
                Get.toNamed(Routes.HOME);
              },),
              const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Text('OR',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),)
                ),
              ),
              OutlinedAppButton(text: 'Login via OTP',onPressed: (){
                Get.toNamed(Routes.SigninViaOtp);
              },),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: RichText(
                      text:
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap =(){},
                          children: const [
                            TextSpan(text: 'Don’t have an account? ',style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'outfit')),
                            TextSpan(text: 'Register',style: TextStyle(color: Color(0xff106EDC),fontSize: 18,fontFamily: 'outfit'))
                          ])),
                ),
              )

            ],

          ),
        )
    );
  }

}
