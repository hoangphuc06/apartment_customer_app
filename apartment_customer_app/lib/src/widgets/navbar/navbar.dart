import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  const NavBar({Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Tên tui nè"),
            accountEmail: Text("Email@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://picsum.photos/250?image=9",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.png'),
                fit: BoxFit.cover
              ),
            ),
          ),
          // Trang chủ
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Trang chủ"),
            onTap: () => null,
          ),
          // Tin tức
          ListTile(
            leading: Icon(Icons.assignment_rounded),
            title: Text("Tin tức"),
            onTap: () => {
              Navigator.pushReplacementNamed(context, "news_page"),
            },
          ),
          // Phản hồi
          ListTile(
            leading: Icon(Icons.near_me),
            title: Text("Phản hồi"),
            onTap: () => null,
          ),
          Divider(),
          //Đăng xuất
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Đăng xuất"),
            onTap: () => {
              FirebaseAuth.instance.signOut().then((value) => {
                Navigator.pushReplacementNamed(context, "login_page"),
              }),
            },
          ),
        ],
      ),
    );
  }

}
