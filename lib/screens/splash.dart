import 'dart:async';
import 'package:soft_bill/Animation/FadeAnimation.dart';
import 'package:soft_bill/list/multi_form.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  bool isLogin = false;

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MultiForm())));
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: 3000,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 20,
                  width: 300,
                  height: 200,
                  child: FadeAnimation(1.3, Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/2_logo.png')
                        )
                    ),
                  )),
                ),
                Positioned(
                  top: 10,
                  left: 25,
                  width: 300,
                  height: 650,
                  child: FadeAnimation(1.3, Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/lady.jpeg')
                        )
                    ),
                  )),
                ),
                Positioned(
                  top:20,
                  height: 1200,
                  left: 80,
                  width: 200,
                  child: FadeAnimation(1.3, Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/MIN.png')
                        )
                    ),
                  )),
                ),
                Positioned(
                  top:20,
                  height: 1200,
                  left: 80,
                  width: 200,
                  child: FadeAnimation(1.3, Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/MIN.png')
                        )
                    ),
                  )),
                ),
              ],
            ),
          ),
        )
    );
  }
}