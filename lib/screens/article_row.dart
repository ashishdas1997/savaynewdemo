import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleRow extends StatefulWidget {
  @override
  _ArticleRowState createState() => _ArticleRowState();
}

class _ArticleRowState extends State<ArticleRow> {

  bool isFavourite= false;

  void toggleFavouriteStatus() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: Firestore.instance.collection('articles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();

          if (!snapshot.hasData) {
            return const Text('Loading');
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                DocumentSnapshot myarticles =
                snapshot.data.documents[index];
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.only(top: 22, bottom: 10, left: 8),
                          child: Text(
                            myarticles['category'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(49, 67, 89, 0.8)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 22, right: 30, bottom: 10),
                          child: Text(
                            ' See all',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                    (myarticles['category'] == 'Recent')?SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Container(
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
                                                myarticles['imageLink'],
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                      children: <Widget>[
                                                        Container(
                                                          padding:
                                                          EdgeInsets.all(0.0),
                                                          child: GestureDetector(
                                                            behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                            child: Icon(
                                                              (isFavourite
                                                                  ? Icons.favorite
                                                                  : Icons
                                                                  .favorite_border),
                                                              color: Colors.grey,
                                                              size: 16,
                                                            ),
                                                            onTap: () =>
                                                                toggleFavouriteStatus(),
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
                                          myarticles['title'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                              Color.fromRGBO(49, 67, 89, 0.8),
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              myarticles['timeAdded'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            (myarticles['contentType'] == 'Audio')
                                                ? Icon(
                                              Icons.audiotrack,
                                              size: 15,
                                              color: Colors.grey.shade400,
                                            )
                                                : (myarticles['contentType'] ==
                                                'Video')
                                                ? Icon(
                                              Icons.play_arrow,
                                              size: 15,
                                              color:
                                              Colors.grey.shade400,
                                            )
                                                : Icon(
                                              Icons.event_note,
                                              size: 15,
                                              color:
                                              Colors.grey.shade400,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              myarticles['contentType'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                    :Text('Nothing to show'),
                  ],
                );
              },
            );
          }
        }
        );
  }
}
