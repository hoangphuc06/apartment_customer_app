import 'package:apartment_customer_app/src/pages/bill/card/bill_card.dart';
import 'package:apartment_customer_app/src/pages/bill/firebase/fb_billinfo.dart';
import 'package:apartment_customer_app/src/pages/bill/firebase/fb_contract.dart';
import 'package:apartment_customer_app/src/pages/bill/view/bill_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillPaid extends StatefulWidget {
  // const BillPaid({Key? key}) : super(key: key);
  final String idRoom;
  BillPaid({required this.idRoom});
  @override
  _BillPaidState createState() => _BillPaidState();
}

class _BillPaidState extends State<BillPaid> {
  bool isPaid = false;
  BillInfoFB billInfoFB = new BillInfoFB();
  ContractFB contractFB = new ContractFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: _title("Danh sách hóa đơn"),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: contractFB.collectionReference
                    .where('room', isEqualTo: this.widget.idRoom)
                    .where('liquidation', isEqualTo: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder(
                            stream: billInfoFB.collectionReference
                                .where('idContract', isEqualTo: x['id'])
                                .where('status', isEqualTo: 'Đã thanh toán')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, i) {
                                      QueryDocumentSnapshot y =
                                          snapshot.data!.docs[i];
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BillCard(
                                              id: y['idBillInfo'],
                                              paymentTerm: y['paymentTerm'],
                                              funtion: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BillDetailPage(
                                                              flag: false,
                                                              id: x[
                                                                  'idBillInfo'],
                                                            )));
                                              })
                                        ],
                                      );
                                    });
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                }),
          )
        ])));
  }
}

Widget emptyTab() {
  return Center(
      child: Text(
    "Dữ liệu trống",
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
  ));
}

_title(String text) => Text(
      text,
      style: TextStyle(
          color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
    );
