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
    setState(() {
      loading = true;
    });
    QuerySnapshot q = await firestore.collection('articles').getDocuments();
    loadedArticles = q.documents;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
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
        body: loading == true
            ? Container(
                child: Center(
                  child: Text('Loading'),
                ),
              )
            : Container(
                child: loadedArticles.length == 0
                    ? Center(
                        child: Text(' No Articles to display'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: loadedArticles.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          String note = loadedArticles[index].documentID;
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title:
                                    Text(loadedArticles[index].data['title']),
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      loadedArticles[index].data['imageLink']),
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
                                          .document(loadedArticles[index].documentID)
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

                                          'Category: ${loadedArticles[index].data['category']}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'Content Type: ${loadedArticles[index].data['contentType']}')
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      )));
  }
}
