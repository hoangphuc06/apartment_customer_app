import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/my_info/model/my_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

  MyInfo _myInfo = MyInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("account").doc(FirebaseAuth.instance.currentUser!.uid.toString()).get()
        .then((value) => {
      print(value["idUser"]),
      FirebaseFirestore.instance.collection("dweller").doc(value["idUser"]).get()
          .then((value) => {
        _myInfo = MyInfo.fromDocument(value),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: myGreen,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Thông tin chi tiết", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.person, "Họ tên", _myInfo.name.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.wc, "Giới tính", _myInfo.gender.toString()=="0"? "Nam" : "Nữ"),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.cake, "Ngày sinh", _myInfo.birthday.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.credit_card_rounded, "CMND", _myInfo.cmnd.toString()==""?"Trống":_myInfo.cmnd.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.location_on, "Quê quán", _myInfo.homeTown.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.build, "Nghề nghiệp", _myInfo.job.toString()),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Cư trú", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.home, "Căn hộ", _myInfo.idApartment.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(
                        Icons.person_pin,
                        "Vai trò",
                        _myInfo.role.toString()=="1"?"Chủ hộ" : _myInfo.role.toString()=="2"?"Người thân chủ hộ" : "Người thuê lại"
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Liên hệ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.phone, "Số điện thoại", _myInfo.phoneNumber.toString()==""?"Trống":_myInfo.phoneNumber.toString()),
                    SizedBox(height: 20,),
                    _detailInfo(Icons.email, "Email", _myInfo.email.toString()==""?"Trống":_myInfo.email.toString()),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _detailInfo(IconData icons, String title, String value) => Row(
    children: [
      Icon(icons),
      SizedBox(width: 5,),
      Text(title, style: TextStyle(fontSize: 15),),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 15),),
    ],
  );
}
