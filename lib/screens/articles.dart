import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savaynewdemo/models/my_colors.dart';
import 'package:savaynewdemo/screens/article_row.dart';
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
  bool isFavourite = false;

//  getArticles() async {
//    QuerySnapshot q = await firestore.collection('articles').getDocuments();
//    loadedArticles = q.documents;
//
//  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 248, 248, 1),
          title: Text(
            'Library',
            style: TextStyle(
              fontSize: 23,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              color: MyColor.primaryAssentColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddArticle()));
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelColor: Theme.of(context).accentColor,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).primaryColorLight,
                  labelStyle: TextStyle(
                    fontFamily: 'sen',
                    fontSize: 16,
                  ),
                  tabs: <Widget>[
                    Tab(
                      text: 'Aisles',
                    ),
                    Tab(
                      text: 'Categories',
                    ),
                    Tab(
                      text: 'Favourites',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('articles').snapshots(),
            builder: (context, snapshot) {
              DocumentSnapshot myarticles = snapshot.data.documents[index];
              if (snapshot.data == null) return CircularProgressIndicator();

              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return TabBarView(children: <Widget>[
                  ArticleRow(),
                  Container(
                    child: Text(),
                  ),
                  Container(),
                ]);
              }
            }),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).primaryColorLight,
          currentIndex: 2,
          showUnselectedLabels: true,
          unselectedLabelStyle:
              TextStyle(color: Theme.of(context).primaryColorLight),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.border_outer),
              title: Text('Library'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text('Notes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              title: Text('Account'),
            ),
          ],
        ),
      ),
    );
  }
}
