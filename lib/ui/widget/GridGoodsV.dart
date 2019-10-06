import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/common/entity/Home.dart';

class GridGoodsV extends StatelessWidget {
  GridGoodsV({Key key, @required this.goods}) : super(key: key);
  final Goods goods;

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(8)),
//        color: DColor.mf,
//      ),
        child: Material(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              fit: BoxFit.fill,
              imageUrl: goods.imgUrl,
              width: 168,
              height: 168,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
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
    ));
  }
}
