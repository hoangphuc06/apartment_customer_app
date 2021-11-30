import 'dart:async';
import 'dart:ui';

import 'package:apartment_customer_app/src/pages/home/view/home_page.dart';
import 'package:apartment_customer_app/src/pages/tab/view/tabs_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, "login_page");
      // if (FirebaseAuth.instance.currentUser==null)
      //   Navigator.pushReplacementNamed(context, "login_page");
      // else
      // {
      //   FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get().then((value) => {
      //     print("id nè:" + value["idUser"].toString()),
      //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(idUser: value["idUser"].toString(),))),
      //   });
        //Navigator.pushReplacementNamed(context, "tabs_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome.png')
                )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DREAM \nBUILDING',
                  style: GoogleFonts.alike(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Giải Pháp Quản Lý Chung Cư Thông Minh \nKết Nối Giữa Ban Quản Lý Và Cư Dân Tòa Nhà.',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15.0),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.bottomCenter,
            // child: MainButton(
            //   name: "",
            //   onpressed: (){},
            // ),
            child: Text(
              "Phiên bản 1.0",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100
              ),
            ),
          ),
        ],
      ),
    );
  }
}
