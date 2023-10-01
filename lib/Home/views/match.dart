
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/bindings/home_binding.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import '../../widgets/primary_button.dart';



class MatchView extends GetView<HomeBinding> {
  MatchView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child:  Column(
              children: [
                Stack(
                  children: [
                    const SizedBox(height: 20,),


                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 80,right: 30),
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(15 / 360),

                          child: Stack(
                            children: [
                              Card(
                                shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                                elevation: 4,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),

                                    child: Image.asset("assets/images/home_dummy.png",height: 250,)),
                              ),
                              Container(
                                transform: Matrix4.translationValues(-80, -60, 0.0),
                                child: Positioned(
                                  top: 0,
                                    child: RotationTransition(
                                        turns: AlwaysStoppedAnimation(-10 / 360),

                                        child: Image.asset("assets/images/like.png"))),
                              ),

                            ],
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 180,left: 30),
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-12 / 360),

                          child: Stack(
                            children: [
                              Card(
                                shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                clipBehavior: Clip.antiAlias,
                                elevation: 4,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset("assets/images/home_dummy.png",height: 250,)),
                              ),
                              Container(
                                transform: Matrix4.translationValues(-80, 170, 0.0),

                                child: Positioned(
                                  bottom: 0,
                                    child: RotationTransition(
                                        turns: AlwaysStoppedAnimation(-10 / 360),

                                        child: Image.asset("assets/images/like.png"))),
                              ),

                            ],
                          )),
                    ),




                  ],

                ),

                const Padding(
                  padding: EdgeInsets.only(top: 80,bottom: 10),
                  child: Text('It’s a match, Jake!',style: TextStyle(color: Color(0xFF7F4458),fontFamily: 'sk' ,fontSize: 26,fontWeight: FontWeight.w700)),
                ),
                const Text('Start a conversation now with each other',style: TextStyle(color:Color(0xFF7F4458),fontFamily: 'sk' ,fontSize: 14,fontWeight: FontWeight.w400)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),
                  child: MaterialButton(
                    disabledColor: const Color(0xff393939),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0.0,
                    color: const Color(0xff7F4458),
                    height: 45,
                    minWidth: double.infinity,
                    onPressed: (){
                      Get.toNamed(Routes.chatMessage);
                    },
                    child: const Text(
                      "Say hello",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600,
                      color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15,right: 40,left: 40),
                  child: MaterialButton(
                    disabledColor: const Color(0xff393939),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0.0,
                    color: const Color(0xff5A131D).withOpacity(0.1),
                    height: 45,
                    minWidth: double.infinity,
                    onPressed: (){
                      Get.back();

                    },
                    child: const Text(
                      "Keep swiping",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600,
                      color: Color(0xff5A131D)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}
