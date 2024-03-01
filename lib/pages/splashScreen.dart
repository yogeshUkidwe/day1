import 'dart:async';

import 'package:flutter/material.dart';

import 'homeScreen.dart';
class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    MyHomePage()
            )
        )
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.amber.shade100,
        child:Image.network('https://desteksolutions.com/assets/images/Destek_registered2-1.png')
    );
  }
}
