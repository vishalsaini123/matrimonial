
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_passordform_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/outline_loginbutton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../widgets/primary_button.dart';
import '../controllers/auth_controller.dart';



class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Center(child: Text('Matrimonial.ai',style: TextStyle(color: Color(0xff7F4458),fontFamily: 'margarine' ,fontSize: 23,fontWeight: FontWeight.w500),)),),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign In',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
                ),
                 AppTextFormField(hintText: 'Email or mobile number',showLabel: false,controller: emailController,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: textEditingController,
                    obscureText: controller!.showPassowrd.value,
                    maxLines: 1,
                    autofocus: false,
                    enabled: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                        isDense: true,
                        suffixIcon: IconButton(icon:controller!.showPassowrd.value?Image.asset("assets/images/passwordoff.png"):Image.asset("assets/images/password.png"), onPressed:()=>controller.showPassowrd.value=!controller.showPassowrd.value,),
                        hintStyle: const TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit'),
                        hintText: "Password",
                        fillColor:  const Color(0xFFFFFFFF),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                  )

                  ),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,right: 8),
                    child: TextButton(onPressed:(){
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    }, child: const Text('Forgot Password?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 15,fontWeight: FontWeight.w400),),)
                  ),
                ],),
                const SizedBox(height: 20,),
                PrimaryButton(text: "Sign In",onPressed: (){
                //  Get.offAllNamed(Routes.HOME);
                  controller.signInQbUser(emailController.text, textEditingController.text);

                },),
                const Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: Text('OR',style: TextStyle(color: Color(0xff505050),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),)
                  ),
                ),
                OutlinedAppLoginButton(text: 'Login with Face',onPressed: (){
                  

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
    });
  }

}
