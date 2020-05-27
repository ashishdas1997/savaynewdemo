import 'package:flutter/material.dart';
import '../screens/category_card.dart';

class CategoryRow extends StatelessWidget {
  final List rowElements;
  CategoryRow(this.rowElements);

  @override
  Widget build(BuildContext context) {
    final cartData = rowElements.iterator;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 22, bottom: 10, left: 8),
              child: Text(
                rowElements.first.contentType,
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
              children: rowElements
                  .map(
                    (articleData) => CategoryCard(categoryData: articleData),
                  )
                  .toList(),
            )),
      ],
    );
  }
}
