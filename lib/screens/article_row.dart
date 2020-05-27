import 'package:flutter/material.dart';
import '../screens/article_card.dart';
import 'package:provider/provider.dart';

class ArticleRow extends StatefulWidget {
  final List rowArticles;
  ArticleRow(this.rowArticles);

  @override
  _ArticleRowState createState() => _ArticleRowState();
}

class _ArticleRowState extends State<ArticleRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 22, bottom: 10, left: 8),
              child: Text(
                widget.rowArticles.first.type,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(49, 67, 89, 0.8)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 22, right: 30, bottom: 10),
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
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.rowArticles
                  .map(
                    (articleData) => ArticleCard(articleData: articleData),
                  )
                  .toList(),
            )),
      ],
    );
  }
}
