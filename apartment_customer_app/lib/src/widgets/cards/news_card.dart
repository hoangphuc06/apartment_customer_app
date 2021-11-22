import 'package:apartment_customer_app/src/pages/news/model/news_model.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_detail_page.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final funtion;
  const NewsCard({Key? key, required this.news, required this.funtion}) : super(key: key);

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
        margin: EdgeInsets.only(bottom: 12),
        child: Text(
          this.news.title.toString(),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }
}
