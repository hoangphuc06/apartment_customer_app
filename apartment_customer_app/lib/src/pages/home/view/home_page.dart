import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/navbar/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var idUser;
  var name;
  var email;

  Future<String> getIdUser(BuildContext context) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection("account")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
    idUser = doc["idUser"];
    print(idUser);

    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection("dweller")
        .doc(idUser)
        .get();
    name = doc1["name"];
    email = doc1["email"];
    print(name);
    return idUser;
  }

  // Future<String> getNameUser(BuildContext context) async {
  //   DocumentSnapshot doc = await FirebaseFirestore.instance
  //       .collection("dweller")
  //       .doc(idUser)
  //       .get();
  //   name = doc["name"];
  //   print(name);
  //   return name;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //WidgetsBinding.instance!.addPostFrameCallback((_) => getIdUser(context));
    //WidgetsBinding.instance!.addPostFrameCallback((_) => getNameUser(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: myGreen, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Trang chủ", style: TextStyle(color: myGreen,),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout), tooltip: "Đăng xuất",)
        ],
      ),
      body: SingleChildScrollView(

      ),
    );
  }
}
