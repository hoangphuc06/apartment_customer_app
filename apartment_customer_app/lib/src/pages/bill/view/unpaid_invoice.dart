import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/bill/card/bill_card.dart';
import 'package:apartment_customer_app/src/pages/bill/firebase/fb_billinfo.dart';
import 'package:apartment_customer_app/src/pages/bill/firebase/fb_contract.dart';
import 'package:apartment_customer_app/src/pages/bill/view/bill_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UnpaidInvoice extends StatefulWidget {
  // const UnpaidInvoice({Key? key}) : super(key: key);
  final String idRoom;
  UnpaidInvoice({required this.idRoom});
  @override
  _UnpaidInvoiceState createState() => _UnpaidInvoiceState();
}

class _UnpaidInvoiceState extends State<UnpaidInvoice> {
  bool isPaid = false;
  BillInfoFB billInfoFB = new BillInfoFB();
  ContractFB contractFB = new ContractFB();
  List<String> listIdRoom = <String>[];

  Future<void> loadData() async {
    var now = DateTime.now();
    listIdRoom.add('s');
    Stream<QuerySnapshot> query = billInfoFB.collectionReference
        .where('monthBill', isEqualTo: now.toLocal().month.toString())
        .where('yearBill', isEqualTo: now.toLocal().year.toString())
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        listIdRoom.add(t['idRoom']);
      });
    });
  }

  TextEditingController _id = TextEditingController();
  @override
  void initState() {
    billInfoFB.collectionReference
        .doc('1637506451651601')
        .get()
        .then((value) => {_id.text = value['idRoom']});
    loadData();
    super.initState();
  }

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
                                .where('status', isEqualTo: 'Chưa thanh toán')
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
                                                              id: y[
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
