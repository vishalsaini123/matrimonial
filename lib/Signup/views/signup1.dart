import 'dart:ffi';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_ai/Signup/controllers/signup_controller.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/data/custompageindicator.dart';
import 'package:matrimonial_ai/utils/dialog_utils.dart';
import 'package:matrimonial_ai/utils/snackbar_utils.dart';
import 'package:matrimonial_ai/widgets/AppDropDownInput.dart';
import 'package:matrimonial_ai/widgets/app_text_field.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/app_text_radiobutton.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:page_view_indicator_ns/page_view_indicator_ns.dart';

import '../../routes/app_pages.dart';
import '../../widgets/primary_button.dart';

class SignUp1 extends GetView<SignUpController> {
  SignUp1({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ddController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController nativePlaceController = TextEditingController();
  TextEditingController addCollegeNameController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController complexityController = TextEditingController();
  PageController pageController = PageController();
  static const length = 3;

  final pageIndexNotifier = ValueNotifier<int>(0);

  String gender = "Male";
  String religion = "Any";

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: CustomPageIndicator(
                        currentPage: controller.profilepageprogress.value,
                        pageCount: 9,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        allowImplicitScrolling: true,
                        controller: pageController,
                        onPageChanged: (num) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.profilepageprogress(num);

                        },
                        children: [
                          profile1(),
                          AppRadioButtonsFormField(
                              text: "Select your gender",
                              callback: (v) => gender = v),
                          dob(),
                          uploadPhotos(context),
                          nativePlace(),
                          highestEducation(),
                          workProfile(context),
                          religiousBelieve(),
                          heightProfile()
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text('This will be shown to your profile',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'outfit')),
                        ),
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 20,
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            if(controller.profilepageprogress.value==0){
                              if (firstNameController.text.isEmpty ||
                                  lastNameController.text.isEmpty ||
                                  passwordController.text.isEmpty ) {
                                SnackBarUtils.showMsg("Please enter all fields");
                                return;
                              }
                              else{
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }

                            }


                            if(controller.profilepageprogress.value==1){
                            pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                            }

                            if(controller.profilepageprogress.value==2){
                              if (controller.age.value.isEmpty ) {
                                SnackBarUtils.showMsg("Please enter DOB");
                                return;
                              }
                              else{

                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            }

                            if(controller.profilepageprogress.value==3){
                              if (controller.imageList.length < 2) {
                                SnackBarUtils.showMsg(
                                    "Please select at least two images");
                                return;
                              }
                              else{
                                print("1");
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            }


                          if(controller.profilepageprogress.value==4){
                            if (nativePlaceController.text.isEmpty ) {
                              SnackBarUtils.showMsg(
                                  "Please enter your native place");
                              return;
                            }
                            else{
                              print("2");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          }

                          if( controller.profilepageprogress.value==5){
                            if (addCollegeNameController.text.isEmpty) {
                              SnackBarUtils.showMsg(
                                  "Please enter your college name");
                              return;
                            }
                            else{
                              print("3");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          }

                          if(controller.profilepageprogress.value==6){
                            if (workPlaceController.text.isEmpty  ) {
                              if (!controller.isCheck.value) {
                                SnackBarUtils.showMsg(
                                    "Please check the option if you not work");
                                return;
                              }
                            }

                            else if (jobController.text.isEmpty) {
                              SnackBarUtils.showMsg("Please enter job title");
                              return;
                            }


                            else if (controller.monthlyIncome.value.isEmpty) {
                              SnackBarUtils.showMsg(
                                  "Please enter your monthly income");
                              return;
                            }
                            else{
                              print("4");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          }
                            if(controller.profilepageprogress.value==7){
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                            if(controller.profilepageprogress.value==8){

                              if (heightController.text.isEmpty ) {
                                SnackBarUtils.showMsg("Please enter your height");
                                return;
                              }



                              else if (weightController.text.isEmpty) {
                                SnackBarUtils.showMsg("Please enter your weight");
                                return;
                              }



                              else if (complexityController.text.isEmpty) {
                                SnackBarUtils.showMsg(
                                    "Please enter your complexity");
                                return;
                              }

                              else{
                                if (controller.profilepageprogress.value == 8) {
                                  controller.registerComplete(
                                      firstNameController.text,
                                      lastNameController.text,
                                      passwordController.text,
                                      gender,
                                      controller.age.value,
                                      nativePlaceController.text,
                                      addCollegeNameController.text,
                                      workPlaceController.text,
                                      jobController.text,
                                      monthController.text,
                                      religion,
                                      heightController.text,
                                      weightController.text,
                                      complexityController.text);
                                }
                              }
                            }





                          },
                          backgroundColor: const Color(0xff7F4458),
                          child: const Icon(
                            Icons.navigate_next,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Widget profile1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Enter your name',
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
        AppTextFormField(
          controller: firstNameController,
          hintText: 'First Name',
          showLabel: false,
          font: 'inter',
        ),
        AppTextFormField(
          controller: lastNameController,
          hintText: 'Middle and Last Name',
          showLabel: false,
          font: 'inter',
        ),
        AppTextFormField(
          controller: passwordController,
          hintText: 'Enter Password',
          showLabel: false,
          font: 'inter',
        ),
      ],
    );
  }

  Widget dob() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Enter your date of birth',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  const Text(
                    'Day',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'outfit',
                        fontSize: 16),
                  ),
                  AppTextFormField(
                    hintText: 'DD',
                    controller: ddController,
                    showLabel: false,
                    font: 'inter',
                    filled: false,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  const Text(
                    'Month',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'outfit',
                        fontSize: 16),
                  ),
                  AppTextFormField(
                    hintText: 'MM',
                    controller: monthController,
                    showLabel: false,
                    font: 'inter',
                    filled: false,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  const Text(
                    'Year',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'outfit',
                        fontSize: 16),
                  ),
                  AppTextFormField(
                    hintText: 'YYYY',
                    controller: yearController,
                    showLabel: false,
                    font: 'inter',
                    filled: false,
                    onChanged: (value) => controller.calculateAge(
                        DateTime.now(),
                        DateTime(
                            int.parse(yearController.text),
                            int.parse(monthController.text),
                            int.parse(ddController.text))),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Center(
            child: Text(
          'Age will be calculated based on your date of birth',
          style: TextStyle(
              color: Colors.black, fontFamily: 'outfit', fontSize: 16),
        )),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
              child: Text(
            'Age',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          )),
        ),
        Obx(() => Center(
                child: Text(
              controller.age.value,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )))
      ],
    );
  }

  Widget uploadPhotos(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Upload your photo',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Add at least 2 photos to continue',
            style: TextStyle(
                color: Colors.black, fontFamily: 'outfit', fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  InkWell(
                      onTap: () => DialogUtils.showImageDialog(context, "Image",
                              () async {
                            controller.imageFile.value = (await controller
                                .getImage(ImageSource.camera))!;
                            if (controller.imageFile != null) {
                              controller.imageList
                                  .add(controller.imageFile.value!);
                            }
                          }, () async {
                            controller.imageFile.value = (await controller
                                .getImage(ImageSource.gallery));
                            if (controller.imageFile != null) {
                              controller.imageList
                                  .add(controller.imageFile.value!);
                            }
                          }),
                      child: imageWidget(controller.imageFile.value?.path)),
                  InkWell(
                      onTap: () => DialogUtils.showImageDialog(context, "Image",
                              () async {
                            controller.imageFile1.value = (await controller
                                .getImage(ImageSource.camera))!;
                            if (controller.imageFile1 != null) {
                              controller.imageList
                                  .add(controller.imageFile1.value!);
                            }
                          }, () async {
                            controller.imageFile1.value = (await controller
                                .getImage(ImageSource.gallery));
                            if (controller.imageFile1 != null) {
                              controller.imageList
                                  .add(controller.imageFile1.value!);
                            }
                          }),
                      child: imageWidget(controller.imageFile1.value?.path)),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  InkWell(
                      onTap: () => DialogUtils.showImageDialog(context, "Image",
                              () async {
                            controller.imageFile2.value = (await controller
                                .getImage(ImageSource.camera))!;
                            if (controller.imageFile2 != null) {
                              controller.imageList
                                  .add(controller.imageFile2.value!);
                            }
                          }, () async {
                            controller.imageFile2.value = (await controller
                                .getImage(ImageSource.gallery));
                            if (controller.imageFile2 != null) {
                              controller.imageList
                                  .add(controller.imageFile2.value!);
                            }
                          }),
                      child: imageWidget(controller.imageFile2.value?.path)),
                  InkWell(
                      onTap: () => DialogUtils.showImageDialog(context, "Image",
                              () async {
                            controller.imageFile3.value = (await controller
                                .getImage(ImageSource.camera))!;
                            if (controller.imageFile3 != null) {
                              controller.imageList
                                  .add(controller.imageFile3.value!);
                            }
                          }, () async {
                            controller.imageFile3.value = (await controller
                                .getImage(ImageSource.gallery));
                            if (controller.imageFile3 != null) {
                              controller.imageList
                                  .add(controller.imageFile3.value!);
                            }
                          }),
                      child: imageWidget(controller.imageFile3.value?.path)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget imageWidget(String? path) {
    print(path);
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.transparent,
          child: ClipOval(
              child: path != null
                  ? Image.file(
                      File(path),
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    )
                  : Image.asset(
                      'assets/images/upload.png',
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    )),
        ),
        Positioned(
            bottom: 10,
            right: 20,
            child: Image.asset(
              'assets/images/upload_add.png',
              fit: BoxFit.contain,
            )),
      ],
    );
  }

  Widget nativePlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'What is your native place?',
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
        AppTextFormField(
          controller: nativePlaceController,
          hintText: 'For eg: Spring field, MA',
          showLabel: false,
          font: 'inter',
        ),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    return const Color(0xFF344054);
  }

  TextStyle radioTextStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Color(0xFF344054),
      fontFamily: 'inter',
      fontWeight: FontWeight.w500,
    );
  }

  Widget highestEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your highest education?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        RadioListTile(
          fillColor: MaterialStateProperty.resolveWith(getColor),
          title: Text(
            "High School",
            style: radioTextStyle(),
          ),
          value: "High School",
          groupValue: controller.selectedHighEdu?.value,
          onChanged: (String? value) {
            controller.selectedHighEdu?.value = value!;
          },
        ),
        RadioListTile(
          fillColor: MaterialStateProperty.resolveWith(getColor),
          title: Text(
            "Undergraduate",
            style: radioTextStyle(),
          ),
          value: "Undergraduate",
          groupValue: controller.selectedHighEdu?.value,
          onChanged: (String? value) {
            controller.selectedHighEdu?.value = value!;
          },
        ),
        RadioListTile(
          fillColor: MaterialStateProperty.resolveWith(getColor),
          title: Text(
            "Postgraduate",
            style: radioTextStyle(),
          ),
          value: "Postgraduate",
          groupValue: controller.selectedHighEdu?.value,
          onChanged: (String? value) {
            controller.selectedHighEdu?.value = value!;
          },
        ),
        RadioListTile(
          fillColor: MaterialStateProperty.resolveWith(getColor),
          title: Text(
            "Prefer not to say",
            style: radioTextStyle(),
          ),
          value: "Prefer not to say",
          groupValue: controller.selectedHighEdu?.value,
          onChanged: (String? value) {
            controller.selectedHighEdu?.value = value!;
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Enter your college name',
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
        AppTextFormField(
          controller: addCollegeNameController,
          hintText: 'Add a school',
          showLabel: false,
          font: 'inter',
        ),
      ],
    );
  }

  Widget workProfile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Where do you work?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        AppTextFormField(
          controller: workPlaceController,
          hintText: 'Add a workplace',
          showLabel: false,
          font: 'inter',
        ),
        Obx(() => Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: AppColors.primary,
                  side: BorderSide(width: 2, color: AppColors.primary),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: controller.isCheck.value,
                  onChanged: (value) {
                    controller.isCheck(value);
                  },
                ),
                const Text(
                  'Select this if you do not work',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'outfit', fontSize: 16),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your job title?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        AppTextFormField(
          controller: jobController,
          hintText: 'Add job title',
          showLabel: false,
          font: 'inter',
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your monthly income?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(() => AppDropdownInput(
              value: controller.monthlyIncome.value.isNotEmpty
                  ? controller.monthlyIncome.value
                  : null,
              onChanged: (String? value) {
                controller.monthlyIncome.value = value!;
                // state.didChange(newValue);
              },
              getLabel: (String value) => value,
              hintText: 'Select Team Member',
              options: const ['100', '200'],
            )),
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

  Widget heightProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'How tall are you?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Obx(
          () => AppTextField(
            value: controller.cmvalue?.value,
            droponChanged: (String? value) {
              controller.cmvalue?.value = value!;
              // state.didChange(newValue);
            },
            keyboardType: TextInputType.number,
            controller: heightController,
            getLabel: (String value) => value,
            options: const ['CM', 'MM'],
            hintText: 'Enter your height',
            showLabel: false,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'What is your weight?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Obx(
          () => AppTextField(
            value: controller.kgvalue?.value,
            droponChanged: (String? value) {
              controller.kgvalue?.value = value!;
              // state.didChange(newValue);
            },
            keyboardType: TextInputType.number,

            getLabel: (String value) => value,
            options: const ['Kg', 'G'],
            controller: weightController,
            hintText: 'Enter your weight',
            showLabel: false,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'What is your complexity?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'outfit',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        AppTextFormField(
          controller: complexityController,
          hintText: 'Enter your complexion',
          showLabel: false,
        ),
      ],
    );
  }
}
