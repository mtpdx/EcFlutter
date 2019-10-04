import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ec/common/entity/Search.dart';

class SearchResultListView extends StatelessWidget {
  final SearchResultListModal list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;

  SearchResultListView(this.list, {this.onItemTap, this.getNextPage});

  @override
  Widget build(BuildContext context) {
    return list.data.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: list.data.length,
            itemExtent: 140,
            itemBuilder: (BuildContext context, int i) {
              SearchResultItemModal item = list.data[i];
              if ((i + 3) == list.data.length) {
                print(
                    'SearchResultListWidget.build next page,current data count ${list.data.length}');
                getNextPage();
              }
              return Container(
                color: Color(0xffffffff),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        fit: BoxFit.fill,
                        imageUrl: item.imageUrl,
                        width: 120,
                        height: 120,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xfff5f5f5)))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              item.wareName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '¥',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFFfe2121)),
                              ),
                              Text(
                                '${(double.parse(item.price))}',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFfe2121)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  '${item.commentcount}人评价',
//                            '23234人评价',
//                          product
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFF999999)),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  '100%好评',
//                            '23234人评价',
//                          product
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFF979896)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
//                              Expanded(child:,),
                                  Flexible(
                                    child: Text(
                                      '${item.shopName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF666666)),
                                    ),
//                                flex: 2,
                                  ),
//                          Text(
//                          '${item.shopName}',
//                            maxLines: 1,
//                            overflow: TextOverflow.ellipsis,
//                            style: GZXConstant.searchResultItemCommentCountStyle,
//                          ),
                                  SizedBox(
                                    width: 8,
                                  ),
//                            Expanded(child: Text('进店',style: TextStyle(fontSize: 12),),),
                                  Text('进店', style: TextStyle(fontSize: 11, color: Color(0xFF333333))),
//                          Icon(Icons.chevron_right,size: 18,color: Colors.grey,) ,
//                              Expanded(
//                                child:
                                  Container(
                                    alignment: Alignment.centerLeft,
//                                  color: Colors.red,
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                ],
//                           ),
                              )),
//                            Icon(
//                              Icons.more_horiz,
//                              size: 15,
//                              color: Color(0xFF979896),
//                            ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            },
          );
  }
}
