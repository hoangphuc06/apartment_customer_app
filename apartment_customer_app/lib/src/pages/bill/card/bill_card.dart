import 'package:flutter/material.dart';

class BillCard extends StatelessWidget {
  final String id;
  final String paymentTerm;
  final funtion;
  const BillCard(
      {Key? key, required this.id, required this.paymentTerm, required this.funtion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funtion,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment),
                SizedBox(
                  width: 5,
                ),
                Text(
                  id,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  paymentTerm,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
