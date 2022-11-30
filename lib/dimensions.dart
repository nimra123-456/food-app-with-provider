


import 'package:flutter/material.dart';

class Dimensions{
  
  //// hints: pageViewContainer = 220 so, complete height is 683
  static  MediaQueryData screen = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static double screenHeight = screen.size.height;
  static double screenWidth = screen.size.height;
    static double pageViewContainer = screenHeight/3.10;
  static double pageViewTextContainer = screenHeight/5.69;
  static double pageView = screenHeight/2.13;
  // dynamic height padding and margin
  static double height10 = screenHeight/68.3;
    static double height5 = screenHeight/136.6;
   static double height20 = screenHeight/34.1;
   static double height15 = screenHeight/45.5;
   static double height30 = screenHeight/22.7;
     static double height45 = screenHeight/15.1;
     // boottom height 6.20

     static double bottomHeightBar = screenHeight/6.20;
    // font size
    static double font20 = screenHeight/34.1;
    static double font26 = screenHeight/26.2;
    static double font16 = screenHeight/40.1;
  
  
    // dynamic width padding and margin
      static double width10 = screenHeight/68.3;
   static double width20 = screenHeight/34.1;
   static double width15 = screenHeight/45.5;
      static double width30 = screenHeight/22.7;
      // radius
    static double radius20 = screenHeight/34.1;
    static double radius30 = screenHeight/22.7;
    static double radius15 = screenHeight/45.5;
    // icon size 28.4
      static double iconSize24 = screenHeight/28.4;
         static double iconSize16 = screenHeight/  42.68;
    
 
      // list view image size

      static double listViewImageSize = screenWidth/4.52;
      static double listViewTextContainer = screenHeight/6.83;

      // ppular image
      static double popularImageSize = screenHeight/2.20;
      // splash screen dimensions
      static double splashImage = screenHeight/2.27;
    


  


}