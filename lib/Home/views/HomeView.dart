import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimonial_ai/Home/controllers/home_controller.dart';
import 'package:matrimonial_ai/Home/views/ChatListView.dart';
import 'package:matrimonial_ai/Home/views/FavouriteView.dart';
import 'package:matrimonial_ai/Home/views/Profile.dart';
import 'package:matrimonial_ai/data/colors.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../data/cons.dart';
import '../../routes/app_pages.dart';
import '../../widgets/primary_button.dart';



class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
      return Obx(() => Scaffold(
          key: scaffoldKey,
          bottomNavigationBar: bottom(),
          drawer: Container(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            color: Colors.black,
            child: Drawer(
              width: double.infinity,
              backgroundColor: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(height: 50,),
                IconButton(onPressed: (){
                  controller.statusbarcolor.value = Colors.white;
                  Navigator.pop(context);}, icon: Image.asset("assets/images/drawer_close.png")),

                Container(
                  height: MediaQuery.sizeOf(context).height/1.4,

                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),

                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Image.asset("assets/images/drawer_icon1.png"),
                        title:  Text('Saved profiles',style: TextStyle(color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),),
                        onTap: () {
                          controller.statusbarcolor.value = Colors.white;

                          Navigator.pop(context);
                        },
                        trailing: Image.asset("assets/images/drawer_icon5.png"),
                      ),
                      const Divider(color: Color(0xFFE5E5E5),height: 1,),
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Image.asset("assets/images/drawer_icon2.png"),
                        title:  Text('Notifications',style: TextStyle(color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),),
                        onTap: () {
                          controller.statusbarcolor.value = Colors.white;

                          Get.back();
                          Get.toNamed(Routes.notficationList);
                        },
                        trailing: Image.asset("assets/images/drawer_icon5.png"),
                      ),
                      const Divider(color: Color(0xFFE5E5E5),height: 1,),
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Image.asset("assets/images/drawer_icon3.png"),
                        title:  Text('Settings',style: TextStyle(color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),),
                        onTap: () {
                          controller.statusbarcolor.value = Colors.white;

                          Navigator.pop(context);
                        },
                        trailing: Image.asset("assets/images/drawer_icon5.png"),
                      ),
                      const Divider(color: Color(0xFFE5E5E5),height: 1,),
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Image.asset("assets/images/drawer_icon4.png"),
                        title:  Text('Subscription',style: TextStyle(color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 17,fontWeight: FontWeight.w500),),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        trailing: Image.asset("assets/images/drawer_icon5.png"),
                      ),
                      const Divider(color: Color(0xFFE5E5E5),height: 1,),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: MaterialButton(
                            disabledColor: const Color(0xff393939),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37),side: const BorderSide(color: Colors.white,width: 1.5 )),
                            elevation: 0.0,
                            height: 44,
                            minWidth: double.infinity,
                            onPressed: (){},
                            child: const Text(
                              "SIGN OUT",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                       const SizedBox(height: 10,),

                       Text.rich(
                        TextSpan(

                          text: 'About Us - ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                              color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 14,fontWeight: FontWeight.w500,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Terms of Use - ',
                                style: TextStyle(
                                  color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 14,fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color:  Colors.white.withOpacity(0.6),fontFamily: 'outfit' ,fontSize: 14,fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                )),
                            // can add more TextSpans here...
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],),
            ),
          ),
          appBar: AppBar(

            systemOverlayStyle:  SystemUiOverlayStyle(
              systemNavigationBarColor: controller.statusbarcolor.value, // Navigation bar
              statusBarColor: controller.statusbarcolor.value, // Status bar
            ),
            centerTitle: controller.selectedItem.value!=1,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child:  InkWell(
                    onTap: (){},
                    child: Image.asset("assets/images/home_headhphone.png",)),
              )
            ],
            leading: IconButton(icon: Image.asset("assets/images/home_burger.png",fit: BoxFit.contain,),onPressed:(){
              controller.statusbarcolor.value = Colors.black;

              scaffoldKey.currentState?.openDrawer();}),
            title:  Text( controller.selectedItem.value==1?'Find your partner':controller.selectedItem.value==2?'Matches':controller.selectedItem.value==3?'Chat':"Profile",style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 23,fontWeight: FontWeight.w400),),),
          body: controller.selectedItem.value==4?ProfileView():
          controller.selectedItem.value==3?ChatListView()
              :controller.selectedItem.value==2?FavouriteView(): Column(
            children: [
              Stack(children: [

                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,

                    child: Container(
                        margin: const EdgeInsets.only(left: 70,right: 70,top: 20),
                        child: Image.asset("assets/images/home_bg_main.png",fit: BoxFit.fill,))),
                Container(


                  child: Obx(() =>!controller.hasSearchData.value?  Center(child: Text("Please wait..",style: TextStyle(color: AppColors.primary),)): controller.isDataLoading.value?Container():SwipeCards(
                    matchEngine: controller.matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.only(left: 40,right: 40,top: 40),

                          height: MediaQuery.of(context).size.height/1.8,
                          decoration:   BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:controller.homeListing.value.data![index].image.isEmpty? const AssetImage("assets/images/home_dummy.png",) as ImageProvider: NetworkImage(Cons.imageBaseUrl+controller.homeListing.value.data![index].image[0])),
                              borderRadius: const BorderRadius.all(Radius.circular(25))),
                          alignment: Alignment.center,
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                               Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.homeListing.value.data![index].name??"NA",style: TextStyle(color: Colors.white,fontFamily: 'sk' ,fontSize: 18,fontWeight: FontWeight.w700)),
                                     Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: SizedBox(
                                        width: 220,
                                          child: Text(controller.homeListing.value.data![index].about??"NA",style: TextStyle(color: Colors.white,fontFamily: 'sk' ,fontSize: 15,fontWeight: FontWeight.w400))),
                                    ),
                                  ],
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin:const EdgeInsets.only(bottom: 30),
                                  height: 220,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:AssetImage("assets/images/home_likebg.png"))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            controller.matchEngine!.currentItem?.like();
                                          },
                                          child: Image.asset("assets/images/home_like.png",)),
                                      InkWell(
                                          onTap: () {
                                            controller.matchEngine!.currentItem?.superLike();
                                          },
                                          child: Image.asset("assets/images/home_comment.png",)),
                                      InkWell(
                                          onTap: () {
                                            controller.matchEngine!.currentItem?.nope();
                                          },
                                          child: Image.asset("assets/images/home_dislike.png",))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      );
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.text}, index: $index");
                    },
                    leftSwipeAllowed: true,
                    rightSwipeAllowed: true,
                    upSwipeAllowed: false,
                    fillSpace: false,
                    likeTag: Center(
                      child: Container(

                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),

                        child: Image.asset("assets/images/like.png"),
                      ),
                    ),
                    nopeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),

                      child:  Image.asset("assets/images/dislike.png"),
                    ),
                    superLikeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Text('Super Like'),
                    ),
                  )),
                ),


              ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 20),
                child: OutlinedAppButton(text: 'View Profile',onPressed: (){},),
              ),

            ],
          )));


  }
  Widget bottom() {
    return SizedBox(

        height: 80, //you can do it with mediaQuery

        child: Stack(
          children: [
            Container(
              transform: Matrix4.translationValues(0.0, -25, 0.0),
              decoration: const BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/images/bottombar_bg.png"))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.selectedItem.value= 1;
                      },
                      icon: Image.asset(
                        controller.selectedItem.value==1?"assets/images/bottom_home_selected.png":"assets/images/bottom_home.png",fit: BoxFit.fill,
                        height: 40,width: 43,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selectedItem.value = 2;
                      },
                      icon: Image.asset(
                        controller.selectedItem.value==2?"assets/images/bottom_heart_selected.png":"assets/images/bottom_heart.png",fit: BoxFit.fill,
                        height: 40,width: 43,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selectedItem.value = 3;
                      },
                      icon: Image.asset(
                        controller.selectedItem.value==3?"assets/images/bottom_chat_selected.png":"assets/images/bottom_chat.png",fit: BoxFit.fill,
                        height: 40,width: 43,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selectedItem.value = 4;
                      },
                      icon: Image.asset(
                        controller.selectedItem.value==4?"assets/images/bottom_profile_selected.png":"assets/images/bottom_profile.png",fit: BoxFit.fill,
                        height: 40,width: 43,
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Visibility(
                      visible: controller.selectedItem.value==1?true:false,
                      child: Container(
                        transform: Matrix4.translationValues(-20, 0.0, 0.0),
                        child: Image.asset(
                          "assets/images/bottom_selected_bg.png",fit: BoxFit.fill,
                        ),
                      ),
                    ),Visibility(
                      visible: controller.selectedItem.value==2?true:false,
                      child: Image.asset(
                        "assets/images/bottom_selected_bg.png",fit: BoxFit.fill,
                      ),
                    ),Visibility(
                      visible: controller.selectedItem.value==3?true:false,

                      child: Container(
                        transform: Matrix4.translationValues(14, 0.0, 0.0),

                        child: Image.asset(
                          "assets/images/bottom_selected_bg.png",fit: BoxFit.fill,
                        ),
                      ),
                    ),Visibility(
                      visible: controller.selectedItem.value==4?true:false,

                      child: Container(
                        transform: Matrix4.translationValues(30, 0.0, 0.0),
                        child: Image.asset(
                          "assets/images/bottom_selected_bg.png",fit: BoxFit.fill,
                        ),
                      ),
                    ),




                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
