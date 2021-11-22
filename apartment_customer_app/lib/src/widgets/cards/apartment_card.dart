import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  final String idRoom;
  final funtion;
  const ApartmentCard({Key? key,
  required this.idRoom,
  required this.funtion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8,),
        child: Row(
            children: [
              Icon(Icons.home),
              SizedBox(width: 5,),
              Text(this.idRoom, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              Spacer(),
            ],
          )
      ),
    );
  }
}
