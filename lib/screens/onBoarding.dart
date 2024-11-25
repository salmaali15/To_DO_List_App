import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_list_app/screens/splash_screen.dart';
import '../utils/cacheHelper.dart';
import 'AppLayoutScreen.dart';

class onBoarding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _onBoarding();

}
class _onBoarding extends State<onBoarding>{
  List<Map<String,dynamic>> onBoardingList = [
    {
      "title" : " Manage your tasks",
      "subtitle" : "You can easily manage all of your daily tasks in DoMe for free.",
      "image" : "assets/images/one.png",
    },
    {
      "title" : "Create daily routine ",
      "subtitle" : "In SlalmUptodo  you can create your personalized routine to stay productive.",
      "image" : "assets/images/three.png",
    },
    {
      "title" : "Orgonaize your tasks",
      "subtitle" : "You can organize your daily tasks by adding your tasks into separate categories.",
      "image" : "assets/images/four.png",
    },
  ];

  PageController controller = PageController();
  void dispose() async{
    super.dispose();
    await CacheHelper.setData(key: "onBoarding",value : true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:[
            PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      onBoardingList[index]["image"],height:271 ,width: 300,),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        onBoardingList[index]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(onBoardingList[index]["subtitle"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> ToDoSplash(),
                      ),
                      );
                    },
                    child: Text("Back",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(controller: controller,
                    count: onBoardingList.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.white,
                        dotWidth: 12,
                        dotHeight: 12,
                        expansionFactor: 1.9,
                        activeDotColor: Colors.white,
                    ),
                    onDotClicked: (index){},
                  ),
                  ElevatedButton(
                    onPressed: (){
                      controller.nextPage(
                        duration: Duration(milliseconds: 2),
                        curve: Curves.easeInOutCirc,
                      );
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> appLayout(),
                      ));
                    },
                    child: Icon(
                      Icons.arrow_forward,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}