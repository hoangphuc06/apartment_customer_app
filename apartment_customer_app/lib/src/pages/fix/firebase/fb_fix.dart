import 'package:cloud_firestore/cloud_firestore.dart';

class FixFB
{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("fix");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String URL,String detail, String title,String idRoom) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance.collection("fix").doc(id).set({
      "timestamp": id,
      "image": URL,
      "detail": detail,
      "title": title,
      "idRoom" : idRoom,
      "status" : "Đang chờ"
    })
        .then((value) => print("completed"))
        .catchError((error)=>print("fail"));
  }
  // Future<void> edit(String id,String URL,String detail, String title) async {
  //   return await FirebaseFirestore.instance.collection("fix").doc(id).update({
  //     "image": URL,
  //     "detail": detail,
  //     "title": title,
  //   })
  //       .then((value) => print("completed"))
  //       .catchError((error)=>print("fail"));
  // }
}