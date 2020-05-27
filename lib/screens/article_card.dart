import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/article_row.dart';

class ArticleCard extends StatefulWidget {
  final DocumentSnapshot articleData;

  ArticleCard({this.articleData});

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    void toggleFavouriteStatus() {
      setState(
        () {
          isFavourite = !isFavourite;
        },
      );
    }

    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 222,
      width: 195,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            child: Wrap(
              children: [
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          widget.articleData.data['imageLink'],
                          width: 195,
                          height: 115,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            color: Colors.white,
                            //margin: EdgeInsets.only( bottom: 5),
                            height: 30,
                            width: 58,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(0.0),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Icon(
                                        (isFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      onTap: () => toggleFavouriteStatus(),
                                    ),
                                  ),
                                  VerticalDivider(),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.event_note,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    //constraints: BoxConstraints.tight(Size(15, 25)),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.articleData.data['title'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(49, 67, 89, 0.8),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Colors.grey.shade400,
                        size: 15,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.articleData.data['addedTime'],
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      (widget.articleData.data['contentType'] == 'Audio')
                          ? Icon(
                              Icons.audiotrack,
                              size: 15,
                              color: Colors.grey.shade400,
                            )
                          : (widget.articleData.data['contentType'] == 'Video')
                              ? Icon(
                                  Icons.play_arrow,
                                  size: 15,
                                  color: Colors.grey.shade400,
                                )
                              : Icon(
                                  Icons.event_note,
                                  size: 15,
                                  color: Colors.grey.shade400,
                                ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.articleData.data['contentType'],
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
