

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';




class SearchView extends GetView<SearchSingPassController> {
   SearchView({Key? key}) : super(key: key);

  //SearchController airportsController = Get.find<SearchController>();
  TextEditingController textEditingController =  TextEditingController();




  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: WillPopScope(
        onWillPop:() async {Get.back(result: "data"); return false;},
        child: Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Center(
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              /* Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: AppTextField(
                hintText: "Enter Id Here...",
                showLabel: false,
                showDivider: false,
                controller: textEditingController,
                suffix: IconButton(onPressed: ()=>{

                    controller.searchFlight(textEditingController.text)},
                icon: const Icon(Icons.search),),
                onChanged: (arg) {
                 // airportsController.searchFlight();
                },
              ),
            ),*/

              const SizedBox(
                height: 8.0,
              ),
              Expanded(child: Obx(() {
                return
                  !controller.hasSearchData.value?const Center(child:  Text("No Data Found",style: TextStyle(fontSize: 18),)):
                  controller.isDataLoading.value? SizedBox(height:MediaQuery.of(context).size.height / 1.3,
                      width:50,child: const Center(child:  CircularProgressIndicator())):controller.searchomdel.value.sex==null? const Center(child:  Text("Failed to fetch user profile",style: TextStyle(fontSize: 18),)):
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Name ${controller.searchomdel.value.name!.value!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Mobile Number : ${controller.searchomdel.value.mobileno!.nbr!.value!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("SEX : ${controller.searchomdel.value.sex!.desc!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("SEX : ${controller.searchomdel.value.race!.desc!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Nationality : ${controller.searchomdel.value.nationality!.desc!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("DOB : ${controller.searchomdel.value.dob!.value!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Noa amount: ${controller.searchomdel.value.noaBasic?.amount!.value!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Noa-Basic Assessment Year: ${controller.searchomdel.value.noaBasic?.yearofassessment!.value}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Regadd : ${controller.searchomdel.value.regadd!.street!.value}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("HDB TYPE : ${controller.searchomdel.value.hdbtype!.desc!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Marital : ${controller.searchomdel.value.marital!.desc!}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Driving license lastupdated : ${controller.searchomdel.value.drivinglicence!.lastupdated}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                          textview("Driving license Demerit Points : ${controller.searchomdel.value.drivinglicence!.totaldemeritpoints!.value}"),
                          const Divider(color: Colors.grey,thickness: 1,),
                        ],
                      ),
                    ),
                  );
              }))
            ],
          ),
        ),
      ),
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
