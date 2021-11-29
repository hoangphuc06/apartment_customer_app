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
          iconTheme: IconThemeData(
            color: myGreen, //change your color here
          ),
          backgroundColor:Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text("Hóa đơn", style: TextStyle(color: myGreen,),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: myGreen,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Chưa thanh toán",),
                Tab(text: "Đã thanh toán",),
              ],
            ),
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
