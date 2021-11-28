import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/bill/view/bill_paid.dart';
import 'package:apartment_customer_app/src/pages/bill/view/unpaid_invoice.dart';
import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  // const BillPage({Key? key}) : super(key: key);
  final String idRoom;
  final String dateContract;
  BillPage({required this.idRoom, required this.dateContract});
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myGreen,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Hóa đơn",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Chưa thanh toán",
              ),
              Tab(
                text: "Đã thanh toán",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UnpaidInvoice(
              idRoom: widget.idRoom,
            ),
            BillPaid(
              idRoom: widget.idRoom,
            )
          ],
        ),
      ),
    );
  }
}
