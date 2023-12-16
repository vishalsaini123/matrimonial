
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_passordform_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/outline_loginbutton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../routes/app_pages.dart';
import '../../widgets/primary_button.dart';



class SignUpVerifyPasswordView extends GetView<SignUpController> {
  SignUpVerifyPasswordView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff101828)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Center(child: Text('Matrimonial.ai',style: TextStyle(color: Color(0xff7F4458),fontFamily: 'margarine' ,fontSize: 23,fontWeight: FontWeight.w500),)),),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:  VisibilityDetector(
              onVisibilityChanged: (visibilityInfo){
                controller.isVisible.value = visibilityInfo.visibleFraction>0;
              },
            key: const Key("key"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Enter OTP sent to ${controller.mobileNumber.value}',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
                )),
                Obx(() =>  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Test OTP  ${controller.registerApiResponse.value.data?.otp}',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
                )),
                const SizedBox(height: 20,),
                SizedBox(
                  child: OtpTextField(
                    numberOfFields: 6,
                    borderColor: const Color(0xFF512DA8),
                    fieldWidth: MediaQuery.of(context).size.width/8,

                    styles: const [
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                      TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit') ,
                    ],
                    enabledBorderColor: Colors.grey.shade300,
                    focusedBorderColor: Colors.grey.shade300,

                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                      code="1111111";
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      controller.registerVerifyOTP(controller.registerApiResponse.value.data?.otp);

                    }, // end onSubmit
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 40),
                    child: Countdown(
                      seconds: 60,
                      build: (BuildContext context, double time) => Text('Didn’t receive the OTP? Retry in ${time.toInt()}',style: const TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 12,fontWeight: FontWeight.w400),),
                      interval: const Duration(milliseconds: 1000),
                      onFinished: () {

                        if(controller.isVisible.value){
                          controller.retryUp(controller.mobileNumber.value);

                        }

                        print('Timer is done!');
                      },
                    )
                ),

                PrimaryButton(text: "Verify",onPressed: (){

                  controller.registerVerifyOTP(controller.registerApiResponse.value.data?.otp);

                },),
                const Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: Text('OR',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),)
                  ),
                ),
                OutlinedAppButton(text: 'Login via Password',onPressed: (){
                  Get.back();
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
          ),
        )
    );
  }

}
