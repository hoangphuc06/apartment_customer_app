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
        margin: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                image: NetworkImage(this.news.image.toString()),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.news.title.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,

                    maxLines: 3,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    readDatime(this.news.timestamp.toString()),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }
}
