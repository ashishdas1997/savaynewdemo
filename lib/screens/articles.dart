import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savaynewdemo/screens/dashboard.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> loadedArticles = [];
  bool expanded = false;
  bool loading = true;


  getArticles() async {
    QuerySnapshot q = await firestore.collection('articles').getDocuments();
    loadedArticles = q.documents;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Articles'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddArticle()));
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('articles').snapshots(),
            builder:(context, snapshot){
              if(snapshot.data == null) return CircularProgressIndicator();

              if(!snapshot.hasData){
                return const Text('Loading');
              }else{
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, int index) {
                    DocumentSnapshot myarticles= snapshot.data.documents[index];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title:
                          Text(myarticles['title']),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                myarticles['imageLink']),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(expanded
                                    ? Icons.expand_less
                                    : Icons.expand_more),
                                onPressed: () {
                                  setState(() {
                                    expanded = !expanded;
                                  });
                                },
                              ),
                              IconButton(icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await firestore.collection('articles')
                                        .document(snapshot.data.documents[index].documentID)
                                        .delete();
                                  }
                              )
                            ],
                          ),
                        ),
                        if (expanded)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(

                                    'Category: ${myarticles['category']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Content Type: ${myarticles['contentType']}')
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                );
              }

            }

        ),

    );
  }
}
