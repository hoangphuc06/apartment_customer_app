import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApartmentPage extends StatefulWidget {
  final String idUser;
  final String idRoom;
  const MyApartmentPage({Key? key, required this.idUser, required this.idRoom}) : super(key: key);

  @override
  _MyApartmentPageState createState() => _MyApartmentPageState();
}

class _MyApartmentPageState extends State<MyApartmentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Căn hộ " + widget.idRoom),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("floorinfo").where('id', isEqualTo: widget.idRoom).snapshots(),
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
                        _detail("Tên căn hộ", x["id"]),
                        SizedBox(height: 10,),
                        _detail("Tầng", x["floorid"]),
                        SizedBox(height: 10,),
                        _detail("Trạng thái", x["status"]),
                        SizedBox(height: 10,),
                        _detail("Số người đang ở", x["numOfDweller"]),

                        //Thông tin loại phòng
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("category_apartment").where('id', isEqualTo: x["categoryid"]).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: Text("No Data"),);
                              } else {
                                QueryDocumentSnapshot y = snapshot.data!.docs[0];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30,),
                                    _title("Loại căn hộ"),
                                    SizedBox(height: 10,),
                                    _detail("Loại", y["name"]),
                                    SizedBox(height: 10,),
                                    _detail("Diện tích", y["area"] + " m2"),
                                    SizedBox(height: 10,),
                                    _detail("Số phòng ngủ", y["amountBedroom"]),
                                    SizedBox(height: 10,),
                                    _detail("Số phòng vệ sinh", y["amountWc"]),
                                    SizedBox(height: 10,),
                                    _detail("Số người tối đa", y["amountDweller"]),
                                  ],
                                );
                              }
                            }
                        ),
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

