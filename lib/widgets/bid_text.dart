import 'package:flutter/material.dart';

import '../dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
   Color? color;
  TextOverflow textFlow;
  double size;

  



 BigText({super.key, required this.text,  this.color= const Color(0xFF332d2b), this.textFlow=TextOverflow.ellipsis,this.size= 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(color: color,fontSize: size==0?Dimensions.font20: size,fontFamily:'Roboto',fontWeight: FontWeight.w400,overflow: textFlow,),
    );
  }
}