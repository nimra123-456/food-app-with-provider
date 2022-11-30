
import 'package:flutter/material.dart';

import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/widgets/small_text.dart';

import '../dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
   final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hidenText= true;
  double textHeight = Dimensions.screenHeight/5.69;
  
  @override
  void initState() {
 
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf= "";
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:secondHalf.isEmpty?SmallText(color:AppColors.paraColor,text: firstHalf,size:Dimensions.font16):Column(children: [
        SmallText(color:AppColors.paraColor,size:Dimensions.font16, text: hidenText?(firstHalf +"..."):(firstHalf+secondHalf)),
        InkWell(
          onTap:(){
            setState(() {
              hidenText = !hidenText;
            });

          },
          child: Row(children: [
            SmallText(text:hidenText?"Show more":"Show less", color:AppColors.mainColor), 
            Icon(hidenText?Icons.arrow_drop_down: Icons.arrow_drop_up, color:AppColors.mainColor)
          ],),
        )
      ],)
    );
  }
}