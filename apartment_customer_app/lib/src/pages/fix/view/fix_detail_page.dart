import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/fix/firebase/fb_fix.dart';
import 'package:apartment_customer_app/src/pages/fix/model/fix_model.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FixInfoPage extends StatefulWidget {
  final Fix fix;
  FixInfoPage(this.fix);
  @override
  _FixInfoPageState createState() => _FixInfoPageState();

}


class _FixInfoPageState extends State<FixInfoPage> {

  FixFB fixFB = new FixFB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Thông tin yêu cầu"),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: fixFB.collectionReference.where('timestamp', isEqualTo: widget.fix.timestamp).snapshots(),
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
                        _titleblack("Tiêu đề"),
                        SizedBox(height: 10,),
                        _note(x["title"]),
                        SizedBox(height: 10,),
                        _titleblack("Miêu tả"),
                        SizedBox(height: 10,),
                        _note(x["detail"]),
                        SizedBox(height: 10,),
                        _detail("Thời gian gửi yêu cầu", readDatime(x["timestamp"])),
                        SizedBox(height: 10,),
                        _statusdetail("Trạng thái", x["status"]),

                        //hình ảnh
                        SizedBox(height: 30,),
                        _titleblack("Hình ảnh"),
                        SizedBox(height: 10,),
                        x["image"]  == "" ? Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blueGrey.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text("không có hình ảnh"),
                          ),
                        ) : Image.network(x["image"] ),

                        SizedBox(height: 50,)
                      ],
                    );
                  }
                }
            ),
          ),
        )
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.bold
    ),
  );
  _titleblack(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black,
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
  _statusdetail(String name, String detail) => Container(
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
              color: detail=="Đang chờ"? myRed : detail=="Đã tiếp nhận" ? myYellow : myGreen,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );
  _note(String text) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.blueGrey.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Ghi chú",
        //   style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.bold
        //   ),
        // ),
        SizedBox(height: 10,),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10,),
      ],
    ),
  );
  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }
}