
import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String? title;
  String? description;
  String? timestamp;
  String? image;

  News({this.title, this.description, this.timestamp, this.image});

  factory News.fromDocument(DocumentSnapshot doc) {
    return News(
      title: doc["title"],
      description: doc["description"],
      timestamp: doc["timestamp"],
      image: doc["image"]
    );
  }
}