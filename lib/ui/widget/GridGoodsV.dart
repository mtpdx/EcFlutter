import 'package:flutter/material.dart';

import 'package:flutter_ec/common/Color.dart';

import 'package:flutter_ec/common/entity/Home.dart';

class GridGoodsV extends StatelessWidget{
  GridGoodsV({Key key, @required this.goods}):super(key: key);
  final Goods goods;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: DColor.mf,
      ),
      height: 257,
//    width: 168,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 168,
            height: 168,
            child: Image(
              image: NetworkImage(goods.imgUrl),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
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
            padding: EdgeInsets.only(left: 10, right: 10),
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
    );
  }

}
