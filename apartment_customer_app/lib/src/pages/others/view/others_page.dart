import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value) => {
              Navigator.pushReplacementNamed(context, "login_page"),
            });
          },
          child: Text("Log out"),
        ),
      ),
    );
  }
}
