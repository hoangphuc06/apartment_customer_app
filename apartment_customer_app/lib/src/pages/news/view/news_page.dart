import 'package:apartment_customer_app/src/colors/colors.dart';
import 'package:apartment_customer_app/src/pages/news/model/news_model.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_detail_page.dart';
import 'package:apartment_customer_app/src/widgets/appbars/my_app_bar.dart';
import 'package:apartment_customer_app/src/widgets/cards/news_card.dart';
import 'package:apartment_customer_app/src/widgets/navbar/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  int _index = 0;
  int _dataLength = 1;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> snapshot = await _fireStore.collection('news').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Tin tức"),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: getSliderImageFromDb(),
                    builder: (_, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapShot) {
                    return snapShot.data == null ? Center(child: CircularProgressIndicator(),) : CarouselSlider.builder(
                      itemCount: snapShot.data!.length,
                      itemBuilder: (BuildContext context, index, int) {
                        DocumentSnapshot sliderImage = snapShot.data![index];
                        News a = News.fromDocument(sliderImage);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(news: a,)));
                          },
                          child: Stack(
                            children: [
                              Image.network(a.image.toString(), fit: BoxFit.cover, width: double.infinity,),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      a.title.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,

                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      readDatime(a.timestamp.toString()),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                padding: EdgeInsets.all(16),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          onPageChanged:
                              (int i, carouselPageChangedReason) {
                            setState(() {
                              _index = i;
                            });
                          }));
                  }
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("news").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("No Data"));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            News news = News.fromDocument(x);
                            return NewsCard(
                                news: news,
                                funtion: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(news: news,)));
                                }
                            );
                          }
                      );
                    }
                  }
              ),
            ],
          )
        ),
      ),
    );
  }
  String readDatime(String timestamp) {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
    return "${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}  ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }
}
