import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  String title;
  String imageLink;
  String contentType;
  String category;

  getTitle(title) {
    this.title = title;
  }

  getImageLink(imageLink) {
    this.imageLink = imageLink;
  }

  getContentType(contentType) {
    this.contentType = contentType;
  }

  getCategory(category) {
    this.category = category;
  }

  createData() {
    DocumentReference documents =
        Firestore.instance.collection('articles').document();
    Map<String, dynamic> articles = {
      'title': title,
      'imageLink': imageLink,
      'contentType': contentType,
      'category': category
    };
    documents.setData(articles).whenComplete(() {
      print("Article Added");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Article'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Title'),
              textInputAction: TextInputAction.next,
              onChanged: (String title) {
                getTitle(title);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'ImageLink'),
              textInputAction: TextInputAction.next,
              onChanged: (String imageLink) {
                getImageLink(imageLink);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Content Type'),
              textInputAction: TextInputAction.next,
              onChanged: (String contentType) {
                getContentType(contentType);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Category'),
              onChanged: (String category) {
                getCategory(category);
              },
            ),
            RaisedButton(
              onPressed: () {
                createData();
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
