
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/data/custompageindicator.dart';
import 'package:matrimonial_ai/model/Religion.dart';
import 'package:matrimonial_ai/routes/app_pages.dart';
import 'package:matrimonial_ai/widgets/AppDropDownInput.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_radiobutton.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:page_view_indicator_ns/page_view_indicator_ns.dart';

import '../../utils/snackbar_utils.dart';
import '../../widgets/primary_button.dart';



class GenderPreference extends GetView<SignUpController> {
  GenderPreference({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();
  TextEditingController preferredComplexityController =  TextEditingController();
  TextEditingController preferredOccupationController =  TextEditingController();
  TextEditingController preferredNativePlaceController =  TextEditingController();
  PageController pageController = PageController();
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);
  String gender = "Male";
  String religion = "Any";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 30),
            child:  Flex(
              direction: Axis.vertical,
              children: [Expanded(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 10,
                          child: Obx(()=>LinearProgressIndicator(

                            backgroundColor: const Color(0xffFCF5F9),
                            valueColor:   AlwaysStoppedAnimation<Color>(AppColors.primary),
                            value: controller.pageprogress.value,)),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/1.6,
                      child: PageView(

                        scrollDirection: Axis.horizontal,
                        allowImplicitScrolling: true,
                        controller: pageController,
                        onPageChanged: (num){

                          print(num);
                          controller.genderpageprogress.value = num;
                          controller.pageprogress.value = num/5;
                        },
                        children: [

                          AppRadioButtonsFormField(
                              text: "Select preferred gender",
                              callback: (v) => gender = v),
                          religiousBelieve(),
                          preferredComplexity(),
                          preferredOccupation(),

                          preferredNativePlace(),
                          preferredExpectations()

                        ],),
                    ),

                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text( 'This will be shown to your profile',style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'outfit')),

                        ),
                        const Icon(Icons.remove_red_eye_outlined,size: 20,),
                        const Spacer(),
                        FloatingActionButton(onPressed: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            print(controller.pageprogress.value);

                            if(controller.genderpageprogress.value==0){
                              controller.pageprogress.value += 1/5;
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }if(controller.genderpageprogress.value==1){
                              controller.pageprogress.value += 1/5;
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }

                            if(controller.genderpageprogress.value==2){
                              if (preferredComplexityController.text.isEmpty ) {
                                SnackBarUtils.showMsg("Please enter preferred complexity");
                                return;
                              }
                              else{
                                controller.pageprogress.value += 1/5;
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            }

                            if(controller.genderpageprogress.value==3){
                              if (preferredOccupationController.text.isEmpty) {
                                SnackBarUtils.showMsg(
                                    "Please enter preferred occupation");
                                return;
                              }
                              else{
                                controller.pageprogress.value += 1/5;
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            }


                            if(controller.genderpageprogress.value==4){
                              if (preferredOccupationController.text.isEmpty ) {
                                SnackBarUtils.showMsg(
                                    "Please enter your preferred native place");
                                return;
                              }
                              else{
                                controller.pageprogress.value += 1/5;
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            }




                                if (controller.genderpageprogress.value == 5) {

                                  List<String> explist = <String>[];
                                   for(ReligionModel expectation in controller.expectationList)
                                     {
                                       if(expectation.value!){
                                         explist.add(expectation.name!);
                                     }
                                     }
                                  controller.registerPreferences(gender,religion,preferredOccupationController.text,preferredNativePlaceController.text,
                                          preferredComplexityController.text,explist);
                                }

                                },backgroundColor: const Color(0xff7F4458) ,child: const Icon(Icons.navigate_next,size: 35,),),

                      ],),
                  ],

                ),
              )],
            ),
          )

    );
  }

  Widget profile1(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Enter your name',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        SizedBox(height: 10,),
        AppTextFormField(hintText: 'First Name',showLabel: false,font: 'inter',),
        AppTextFormField(hintText: 'Middle and Last Name',showLabel: false,font: 'inter',),

      ],

    );
  }
  Widget dob(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Enter your date of birth',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            width: 80,
            child: Column(children: [
              Text('Day',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),),
              AppTextFormField(hintText: 'DD',showLabel: false,font: 'inter',filled: false,)
            ],),
          ),
          SizedBox(
            width: 80,
            child: Column(children: [
              Text('Month',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),),
              AppTextFormField(hintText: 'MM',showLabel: false,font: 'inter',filled: false,)
            ],),
          ),
          SizedBox(
            width: 100,
            child: Column(children: [
              Text('Year',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),),
              AppTextFormField(hintText: 'YYYY',showLabel: false,font: 'inter',filled: false,)
            ],),
          ),
        ],),
        SizedBox(height: 30,),
        Center(child: Text('Age will be calculated based on your date of birth',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),)),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(child: Text('Age',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 20 ,fontWeight: FontWeight.w600),)),
        ),
        Center(child: Text('0',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 20 ,fontWeight: FontWeight.w600),))




      ],

    );
  }
  Widget uploadPhotos(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Upload your photo',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
         const Padding(
           padding: EdgeInsets.all(8.0),
           child: Text('Add at least 2 photos to continue',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),),
         ),
        const SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            child: Column(children: [

              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: ClipOval(child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset('assets/images/upload.png',fit: BoxFit.contain,),
                )),
              ),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: ClipOval(child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset('assets/images/upload.png',fit: BoxFit.contain,),
                )),
              ),

            ],),
          ),

            SizedBox(
              child: Column(children: [

                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset('assets/images/upload.png',fit: BoxFit.contain,),
                  )),
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset('assets/images/upload.png',fit: BoxFit.contain,),
                  )),
                ),

              ],),
            ),

        ],),



      ],

    );
  }
  Widget preferredComplexity(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Preferred Complexity?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 10,),
        AppTextFormField(
          controller: preferredComplexityController,
          hintText: 'Enter preferred complexion of partner',showLabel: false,font: 'inter',),

      ],

    );
  }
  Widget preferredOccupation(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Preferred occupation',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 10,),
        AppTextFormField(
          controller: preferredOccupationController,
          hintText: 'Enter preferred occupation of partner',showLabel: false,font: 'inter',),

      ],

    );
  }
  Widget preferredNativePlace(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Preferred native place?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 10,),
        AppTextFormField(
          controller: preferredNativePlaceController,
          hintText: 'For eg: Spring field, MA',showLabel: false,font: 'inter',),

      ],

    );
  }
  Widget preferredExpectations(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('What are your expectations?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 30,),
        Obx(() => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: GridView.builder(
              itemCount: controller.expectationList.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: (){

                  print(controller.expectationList[index].value!);
                  if(controller.expectationList[index].value!)
                  {

                    controller.expectationList[index].value = false;
                  }
                  else{
                    controller.expectationList[index].value = true;
                  }
                  controller.expectationList.refresh();

                },
                child: Obx(() => Container(
                  decoration:  BoxDecoration(
                      color: controller.expectationList[index].value!? AppColors.primary:const Color(0xFFFCF5F9),
                      borderRadius: const BorderRadius.all(Radius.circular(60))),
                  child:  Center(child: Text(controller.expectationList[index].name!,textAlign: TextAlign.center,style: TextStyle(color:  controller.expectationList[index].value!?Colors.white:const Color(0xFF797C7B),fontFamily: 'outfit' ,fontSize: 19,fontWeight: FontWeight.w500),)),)),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1
              ),
            ),
          ),
        )),

      ],

    );
  }


  Widget highestEducation(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Your highest education?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),

        RadioListTile(
          title: const Text("High School"),
          value: "High School", groupValue: '', onChanged: (String? value) {  },

        ),
        RadioListTile(
          title: const Text("Undergraduate"),
          value: "Undergraduate", groupValue: '', onChanged: (String? value) {  },),
        RadioListTile(
          title: const Text("Postgraduate"),
          value: "Postgraduate", groupValue: '', onChanged: (String? value) {  },),
        RadioListTile(
          title: const Text("Prefer not to say"),
          value: "Postgraduate", groupValue: '', onChanged: (String? value) {  },),


        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Enter your college name',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 10,),
        const AppTextFormField(hintText: 'Add a school',showLabel: false,font: 'inter',),

      ],

    );
  }
  Widget workProfile(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Where do you work?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const AppTextFormField(hintText: 'Add a workplace',showLabel: false,font: 'inter',),

        Obx(()=>Row(
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: controller.isCheck.value,
              onChanged: (value) {

              controller.isCheck(value);
              },
            ),
            const Text('Add at least 2 photos to continue',style: TextStyle(color: Colors.black,fontFamily: 'outfit',fontSize: 16 ),),
          ],
        )),

        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Your job title?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const AppTextFormField(hintText: 'Add job title',showLabel: false,font: 'inter',),
        const SizedBox(height: 20,),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Your monthly income?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
    const SizedBox(height: 5,),
    Obx(()=>AppDropdownInput(
          value: controller.name.value.isNotEmpty?controller.name.value:null,
          onChanged: (String? value) {

              controller.name.value = value!;
              // state.didChange(newValue);

          },
          getLabel: (String value) => value,
          hintText: 'Select Team Member',options: const ['Loream','Test Data'],)),

      ],

    );
  }
  Widget religiousBelieve() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Select your religious believe',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListView.builder(
                  itemCount: controller.religiousList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: AppColors.primary,
                      side: BorderSide(width: 2, color: AppColors.primary),
                      title: Text(
                        controller.religiousList[index].name!,
                        style: radioTextStyle(),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: controller.religiousList[index].value,
                      onChanged: (value) {
                        setState(() {
                          for (var element in controller.religiousList) {
                            element.value = false;
                          }

                          controller.religiousList[index].value = value;
                          religion = controller.religiousList[index].name!;
                        });
                      },
                    );
                  });
            },
          ),
        )
      ],
    );
  }
  Widget heightProfile(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('How tall are you?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),


        Obx(()=>   AppTextField(
          value: controller.cmvalue?.value,
          droponChanged: (String? value) {

            controller.cmvalue?.value = value!;
            // state.didChange(newValue);

          },
          getLabel: (String value) => value,
          options: const ['CM','MM'],
          hintText: 'Enter your height',showLabel: false,),),

        const SizedBox(height: 20,),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('What is your weight?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        Obx(()=>   AppTextField(
          value: controller.kgvalue?.value,
          droponChanged: (String? value) {

            controller.kgvalue?.value = value!;
            // state.didChange(newValue);

          },
          getLabel: (String value) => value,
          options: const ['Kg','G'],
          hintText: 'Enter your weight',showLabel: false,),),

        const SizedBox(height: 20,),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('What is your complexity?',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        const SizedBox(height: 5,),
        const AppTextFormField(hintText: 'Enter your complexion',showLabel: false,),

      ],

    );
  }
  TextStyle radioTextStyle(){
    return const TextStyle(fontSize: 16,color: Color(0xFF344054),fontFamily: 'inter',fontWeight: FontWeight.w500,);
  }
}
