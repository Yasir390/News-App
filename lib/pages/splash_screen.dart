import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
  });
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Image.asset('images/splash.jpg',
         fit: BoxFit.cover,
           height: height*0.5,
           width: width*0.9,
         ),
         SizedBox(
           height: height*0.04,
         ),
        Text('Top Headlines',style: GoogleFonts.anton(letterSpacing: 0.6,color: Colors.black),),
         SizedBox(
           height: height*0.04,
         ),
         const SpinKitChasingDots(
           color: Colors.blue,
           size: 40,
         )
       ],
      ),
    );
  }
}
