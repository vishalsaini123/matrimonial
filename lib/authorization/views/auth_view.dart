
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../widgets/primary_button.dart';
import '../controllers/auth_controller.dart';



class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  final TextEditingController textEditingController =  TextEditingController();




  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:
         Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Center(
                  child: Text(
                    "Authorization",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                child: OutlinedAppButton(text: "Authorize",onPressed: ()=> controller.authorize() ,),
              ),

              const SizedBox(
                height: 8.0,
              ),
              Expanded(child:
              !controller.hasSearchData.value?const Center(child:  Text("Click on Authorize button",style: TextStyle(fontSize: 18),)):
              controller.isDataLoading.value? SizedBox(height:MediaQuery.of(context).size.height / 1.3,
                  width:50,child:  Center(child:  CircularPercentIndicator(
                    radius: 130.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 15.0,
                    percent: controller.pageprogress.value,
                    center:   Text(
                      "${controller.pageprogress.value*100}%",
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.yellow,
                    progressColor: Colors.red,
                  ))):controller.url.isEmpty? const Center(child:  Text("Failed to fetch user profile",style: TextStyle(fontSize: 18),)):
              controller.url.startsWith("http://localhost:3001/")?Container():
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Visibility(
                  visible:controller.url.startsWith("http://localhost:3001/")?false:true ,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Text("fs")),
                ),
              )
              )
            ],
          ),
        )

    );
  }
  Widget textview(String text){
    

    return Text(text,style: const TextStyle(
      color: Color(0xFF000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ));
  }
}
