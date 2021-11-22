import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/news/model/news_model.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_detail_page.dart';
import 'package:apartment_customer_app/src/pages/tab/view/tabs_page.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/cards/apartment_card.dart';
import 'package:apartment_customer_app/src/widgets/cards/news_card.dart';
import 'package:apartment_customer_app/src/widgets/navbar/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Image(
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/cover.jpg'),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1.5)),
                    width: double.infinity,
                    height: 350,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Dream Building",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "SĐT: 0336281849",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Đ/c: KP6, Linh Trung, Thủ Đức, TP.HCM",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ]))),
        SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: _title("Căn hộ của tôi"),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("rentedRoom").where("idRenter", isEqualTo: this.widget.idUser).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("No Data"),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              QueryDocumentSnapshot x = snapshot.data!.docs[i];
                              return ApartmentCard(
                                idRoom: x["idRoom"],
                                funtion: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TabsPage(idUser: x["idRenter"], idRoom: x["idRoom"])));
                                }
                              );
                            });
                      }
                    }),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: _title("Chung cư"),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _lableButton(size, Icons.mail, "Thông báo", () {

                    }),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: _title("Tài khoản"),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _lableButton(size, Icons.lock, "Đổi mật khẩu", () {

                    }),
                    _lableButton(size, Icons.logout, "Đăng xuất", () {

                    }),
                  ],
                ),
              ),

              SizedBox(height: 50,)
            ]))
      ]),
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );

  _lableButton(Size size, IconData icon, String text, funtion) =>
      GestureDetector(
        onTap: funtion,
        child: Container(
          width: (size.width - 52) / 3,
          height: (size.width - 52) / 4,
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
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
