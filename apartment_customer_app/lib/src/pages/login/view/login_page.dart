import 'dart:ui';

import 'package:apartment_customer_app/src/pages/home/view/home_page.dart';
import 'package:apartment_customer_app/src/pages/tab/view/tabs_page.dart';
import 'package:apartment_customer_app/src/style/my_style.dart';
import 'package:apartment_customer_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_customer_app/src/widgets/dialog/loading_dialog.dart';
import 'package:apartment_customer_app/src/widgets/dialog/msg_dilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //AuthBloc authBloc = new AuthBloc();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Xin chào!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0
                      ),
                    ),
                    Text(
                      "Vui lòng đăng nhập để tiếp tục",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0
                      ),
                    ),

                    SizedBox(height: 30,),
                    _title(Icons.email, "Email"),
                    _emailTextField(),

                    SizedBox(height: 30,),
                    _title(Icons.lock, "Mật khẩu"),
                    _passwordTextField(),

                    SizedBox(height: 30,),
                    MainButton(
                      name: "Đăng nhập",
                      onpressed: _onLoginClick,
                    ),

                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "reset_pass_page");
                      },
                      child: Text(
                        "Quên mật khẩu?",
                        style: MyStyle().style_text_lg_hint(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonLogin() => FlatButton(
    onPressed: () {  },
    child: Container(

    ),
  );

  void _onLoginClick() async {
    String email = _emailController.text.trim();
    String pass = _passController.text.trim();

    if(_formkey.currentState!.validate()) {

      LoadingDialog.showLoadingDialog(context, "Loading...");

      if (email=="ad.apartment.m12@gmail.com"){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", "Vui lòng sử dụng đúng loại tài khoản!");
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: pass
        );

        LoadingDialog.hideLoadingDialog(context);

        FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get().then((value) => {
          print("id nè:" + value["idUser"].toString()),
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(idUser: value["idUser"].toString(),))),
        });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {

          LoadingDialog.hideLoadingDialog(context);

          MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", "Tài khoản này chưa được đăng kí");

        } else if (e.code == 'wrong-password') {

          LoadingDialog.hideLoadingDialog(context);

          MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", "Mật khẩu không chính xác");

        }
      }

      // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      // _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass)
      // .then((user) {
      //   LoadingDialog.hideLoadingDialog(context);
      //   FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get().then((value) => {
      //     print("id nè:" + value["idUser"].toString()),
      //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(idUser: value["idUser"].toString(),))),
      //   });
      // });
    }
  }

  _emailTextField() => TextFormField(
    style: MyStyle().style_text_lg_hint(),
    controller: _emailController,
    //cursorColor: myGreen,
    decoration: InputDecoration(
      hintText: "Nhập email...",
      hintStyle: MyStyle().style_text_lg_hint(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập email";
      }
      return null;
    },
  );

  _passwordTextField() => TextFormField(
    obscureText: true,
    style: MyStyle().style_text_lg_hint(),
    controller: _passController,
    decoration: InputDecoration(
      hintText: "Nhập mật khẩu...",
      hintStyle: MyStyle().style_text_lg_hint(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );

  _title(IconData icon, String text) => Container(
    child: Row(
      children: [
        Icon(icon, color: Colors.white,),
        SizedBox(width: 10,),
        Text(text, style: MyStyle().style_text_lg(),)
      ],
    ),
  );
}

