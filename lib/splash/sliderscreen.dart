import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimonial_ai/Signup/views/signup.dart';
import 'package:matrimonial_ai/authorization/views/login.dart';
import 'package:matrimonial_ai/widgets/outline_button.dart';
import 'package:matrimonial_ai/widgets/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderScreens extends StatefulWidget {

  const SliderScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderScreens> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreens> {

  PageController controller = PageController();

  List<String> text1 = ["Find your perfect match","Stay connected, always","Verified profiles only"];
  List<String> text2 = ["Discover your soulmate with our comprehensive search filters","Chat, video call, and connect with potential matches anytime, anywhere","Connect with genuine individuals. Create and view detailed profiles to find your ideal life partner"];
  int _curr = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(

      backgroundColor: Colors.white,
      body: 

      ListView(children: [

        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height/1.7,
          child: Stack(
            children: [


              PageView(

                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                controller: controller,
                onPageChanged: (num){
                  setState(() {
                    _curr = num;
                  });
                },
                children: [
                  ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset('assets/images/slider1.png',fit: BoxFit.fill,)),
                  ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset('assets/images/slider2.png',fit: BoxFit.fill,)),
                ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white30],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset('assets/images/slider3.png',fit: BoxFit.contain,))
              ],),
              const Padding(
                padding:  EdgeInsets.only(left: 30,right: 30,top: 20),
                child:  Text('Matrimonial.ai',style: TextStyle(color: Color(0xff7F4458),fontFamily: 'margarine' ,fontSize: 23,fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SmoothPageIndicator(controller: controller, count: 3,
            effect: const CustomizableEffect(dotDecoration: DotDecoration(color: Color(0xffF3B9CD),height: 5,width: 20,borderRadius: BorderRadius.all(Radius.circular(20))), activeDotDecoration: DotDecoration(color: Color(0xffF3B9CD),height: 5,width: 30,borderRadius: BorderRadius.all(Radius.circular(20)))),),


           Padding(
            padding:  const EdgeInsets.only(left: 35,right: 35,top: 20),
            child: Text(text1[_curr],style: const TextStyle(color: Color(0xff444246),fontSize: 26,fontFamily: 'outfit',fontWeight: FontWeight.w700),),
          ),
           Padding(
            padding:  const EdgeInsets.only(left: 30,right: 30,top: 20),
            child:  Text(text2[_curr],style: const TextStyle(color: Color(0xff505050),fontSize: 14,fontFamily: "outfit",fontWeight: FontWeight.w400),),
          ),
          Container(
              margin: const EdgeInsets.only(left: 25,right: 25,top: 20),
              child: PrimaryButton(
                text: 'Join Matrimonial',onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignUpView()),
                );
              },)),
          Container(
              margin: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 20),
              child: OutlinedAppButton( text: 'Sign In',onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginView()),
                );
              },)),
        ],)


      ],),
    );
  }
}
