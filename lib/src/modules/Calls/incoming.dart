import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/userP.jpeg"),)
        ),
        
        child:  BackdropFilter(
          filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child:  Container(
            decoration:  BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
    );
  }
}