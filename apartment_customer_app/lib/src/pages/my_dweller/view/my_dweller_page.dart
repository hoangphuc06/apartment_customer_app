import 'package:apartment_customer_app/src/pages/my_dweller/model/dweller_model.dart';
import 'package:apartment_customer_app/src/pages/my_dweller/view/detail_dweller_page.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/cards/dweller_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyDwellerPage extends StatefulWidget {
  final String idUser;
  final String idRoom;
  const MyDwellerPage({Key? key, required this.idUser, required this.idRoom}) : super(key: key);

  @override
  _MyDwellerPageState createState() => _MyDwellerPageState();
}

class _MyDwellerPageState extends State<MyDwellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Căn hộ " + widget.idRoom),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _title("Danh sách thành viên"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("dweller").where('idApartment',isEqualTo: this.widget.idRoom).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            Dweller dweller = Dweller.fromDocument(x);
                            return DwellerCard(
                              dweller: dweller,
                              funtion: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailDwellerPage(dweller: dweller)));
                              },
                            );
                          });
                    }
                  }),
            ),
          ],
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
}
