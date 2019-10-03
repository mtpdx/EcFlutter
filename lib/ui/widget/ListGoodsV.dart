import 'package:flutter/material.dart';

import 'package:flutter_ec/common/Color.dart';

import 'package:flutter_ec/common/entity/Home.dart';

class ListGoodsV extends StatelessWidget{
  ListGoodsV({Key key, @required this.goods}):super(key: key);
  final Goods goods;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: DColor.mf,
      ),
      height: 140,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120,
            height: 120,
            child: Image(
              image: NetworkImage(goods.imgUrl),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${goods.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: DColor.m3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${goods.price}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: DColor.main,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
