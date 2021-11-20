import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/navbar/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? idUser;
  const HomePage({Key? key, required this.idUser}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "login_page");
            },
            icon: Icon(Icons.logout), tooltip: "Đăng xuất",)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("dweller").where('id', isEqualTo: this.widget.idUser).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No Data"),);
                } else {
                  QueryDocumentSnapshot x = snapshot.data!.docs[0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Thông tin chi tiết
                      _title("Thông tin chi tiết"),
                      SizedBox(height: 10,),
                      _detail("Họ tên", x["name"]),
                      SizedBox(height: 10,),
                      _detail("Giới tính", x["gender"]=="0"?"Nam":"Nữ"),
                      SizedBox(height: 10,),
                      _detail("Ngày sinh", x["birthday"]),
                      SizedBox(height: 10,),
                      _detail("CMND/CCCD", x["cmnd"]==""?"Trống":x["cmnd"]),
                      SizedBox(height: 10,),
                      _detail("Quê quán", x["homeTown"]),
                      SizedBox(height: 10,),
                      _detail("Nghề nghiệp", x["job"]),

                      //Cư trú
                      SizedBox(height: 30,),
                      _title("Cư trú"),
                      SizedBox(height: 10,),
                      _detail("Căn hộ", x["idApartment"]),
                      SizedBox(height: 10,),
                      _detail("Vai trò", x["role"]=="1"?"Chủ hộ":x["role"]=="2"?"Người thân chủ hộ":"Người thuê lại"),

                      //Liên hệ
                      SizedBox(height: 30,),
                      _title("Liên hệ"),
                      SizedBox(height: 10,),
                      _detail("Số điện thoại", x["phoneNumber"]==""?"Trống":x["phoneNumber"]),
                      SizedBox(height: 10,),
                      _detail("Email", x["email"]==""?"Trống":x["email"]),

                      SizedBox(height: 50,)
                    ],
                  );
                }
              }
          ),
        ),
      ),
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _detail(String name, String detail) => Container(
    padding: EdgeInsets.all(8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blueGrey.withOpacity(0.2)
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );
}
