import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/bill/view/bill_page.dart';
import 'package:apartment_customer_app/src/pages/fix/view/fix_page.dart';
import 'package:apartment_customer_app/src/pages/home/view/home_page.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  final String idUser;
  const TabsPage({Key? key, required this.idUser}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  List<Widget> _widgetOptions = [
    HomePage(),
    NewsPage(),
    FixPage(),
    BillPage(),
  ];

  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("id ne:" + this.widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedItemIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: myGreen,
      iconSize: 30.0,
      selectedItemColor: myGreen,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedItemIndex,
      onTap: _cambiarWidget,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Thông báo"),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: "Sửa chữa"),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "Hóa đơn"),
      ],
    );
  }
}
