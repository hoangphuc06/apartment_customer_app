import 'dart:io';

import 'package:apartment_customer_app/src/pages/fix/firebase/fb_fix.dart';
import 'package:apartment_customer_app/src/style/my_style.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/buttons/main_button.dart';
import 'package:apartment_customer_app/src/widgets/dialog/loading_dialog.dart';
import 'package:apartment_customer_app/src/widgets/title/title_info_not_null.dart';
import 'package:apartment_customer_app/src/widgets/title/title_info_null.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddFixPage extends StatefulWidget {
  final String idRoom;
  const AddFixPage({Key? key, required this.idRoom}) : super(key: key);

  @override
  _AddFixPageState createState() => _AddFixPageState();
}

class _AddFixPageState extends State<AddFixPage> {

  final _formkey = GlobalKey<FormState>();
  File? file;
  String URL = "";
  FixFB fixFB = new FixFB();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Thêm yêu cầu sửa chữa"),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title("Thông tin chi tiết"),
                    SizedBox(height: 10,),

                    TitleInfoNotNull(text: "Tiêu đề"),
                    SizedBox(height: 10,),
                    _titleTextField(),

                    SizedBox(height: 10,),
                    TitleInfoNotNull(text: "Miêu tả"),
                    SizedBox(height: 10,),
                    _detailTextField(),

                    SizedBox(height: 10,),
                    TitleInfoNull(text: "Hình ảnh"),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: file == null ? Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blueGrey.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text("Chọn hình ảnh"),
                        ),
                      )
                          : Container(
                          child: Image.file(file!)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: MainButton(
                  name: "Gửi yêu cầu",
                  onpressed: () {
                    if (file != null)
                      _upload();
                    else _AddNews();
                  },
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _AddNews() async {
    if (_formkey.currentState!.validate()) {
      String id = (new DateTime.now().millisecondsSinceEpoch).toString();
      fixFB.add(URL, _detailController.text, _titleController.text, widget.idRoom).then((value) =>
          Navigator.pop(context)
      );
    }
  }

  _title(String text) =>
      Text(
        text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.bold
        ),
      );

  _titleTextField() =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập tiêu đề"),
          style: MyStyle().style_text_tff(),
          controller: _titleController,
          keyboardType: TextInputType.name,
          minLines: 3,
          maxLines: 5,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập tiêu đề";
            }
            return null;
          },
        ),
      );

  _detailTextField() =>
      Container(
        padding: MyStyle().padding_container_tff(),
        decoration: MyStyle().style_decoration_container(),
        child: TextFormField(
          decoration: MyStyle().style_decoration_tff("Nhập miêu tả"),
          style: MyStyle().style_text_tff(),
          controller: _detailController,
          keyboardType: TextInputType.name,
          minLines: 8,
          maxLines: 15,
          validator: (val) {
            if (val!.isEmpty) {
              return "Vui lòng nhập mô tả";
            }
            return null;
          },
        ),
      );

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future _upload() async {
    String filename = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    Reference ref = FirebaseStorage.instance.ref().child("news").child(
        "post_$filename");
    LoadingDialog.showLoadingDialog(context, "Đang tải lên bài viết...");
    await ref.putFile(file!);
    URL = await ref.getDownloadURL();
    print(URL);
    LoadingDialog.hideLoadingDialog(context);
    await _AddNews();
    // if (_formkey.currentState!.validate()) {
    //   String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    //   await FirebaseFirestore.instance.collection("news").doc(id).set({
    //     "timestamp": id,
    //     "image": URL,
    //     "description": _descriptionController.text.trim(),
    //     "title": _titleController.text.trim(),
    //   })
    //       .then((value) =>{
    //         print("completed"),
    //         Navigator.pop(context)
    //       })
    //       .catchError((error)=>print("fail"));
    // }

  }
}