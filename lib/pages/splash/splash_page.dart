import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../../providers/cart_provider.dart';
import '../../utils/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
late Animation<double> _animation;
late AnimationController _controller;

@override
  void initState() {
  
  
    _controller = AnimationController(vsync: this,duration:const Duration(seconds: 1) )..forward();
    _animation= CurvedAnimation(parent: _controller, curve:Curves.linear );
    Timer(const Duration(seconds: 5), (() => Navigator.pushNamed(context, RouteName.home_screen)));
     
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ScaleTransition(
          scale: _animation,
          child: Center(child: Image.asset("assets/images/tea.jpg", width:Dimensions.splashImage),)),
        const Center(child: Text("The Best Food", style:TextStyle(color:Color(0xFF89dad0), fontSize: 50,fontFamily:"DancingScript", fontWeight: FontWeight.bold )))
      ]),
    );
  }
}