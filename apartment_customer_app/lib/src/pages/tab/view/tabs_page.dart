import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/bill/firebase/fb_contract.dart';
import 'package:apartment_customer_app/src/pages/bill/view/bill_page.dart';
import 'package:apartment_customer_app/src/pages/fix/view/fix_page.dart';
import 'package:apartment_customer_app/src/pages/home/view/home_page.dart';
import 'package:apartment_customer_app/src/pages/my_apartment/view/my_apartment_page.dart';
import 'package:apartment_customer_app/src/pages/my_dweller/view/my_dweller_page.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  final String idUser;
  final String idRoom;
  const TabsPage({Key? key, required this.idUser, required this.idRoom})
      : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  ContractFB contractFB = new ContractFB();
  TextEditingController _dateContract = TextEditingController();
  @override
  void initState() {
    
    super.initState();
    print( _dateContract.text);
    print("id ne:" + this.widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      MyApartmentPage(idUser: this.widget.idUser, idRoom: this.widget.idRoom),
      MyDwellerPage(idUser: this.widget.idUser, idRoom: this.widget.idRoom),
      FixPage(),
      BillPage(idRoom: this.widget.idRoom,dateContract: _dateContract.text,),
    ];
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Căn hộ"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Thành viên"),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: "Sửa chữa"),
        BottomNavigationBarItem(
            icon: Icon(Icons.description), label: "Hóa đơn"),
      ],
    );
  }
}
