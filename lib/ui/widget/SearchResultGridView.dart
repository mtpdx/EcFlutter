import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ec/common/entity/Search.dart';

class SearchResultGridView extends StatelessWidget {
  final SearchResultListModal list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;
  BuildContext _context;

  SearchResultGridView(this.list, {Key key, this.onItemTap, this.getNextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return list.data.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: productGrid(list.data),
          );
  }

  Widget imageStack(String img) => Image.network(
        img,
//        height: 100,
        fit: BoxFit.cover,
      );

  Widget productGrid(List<SearchResultItemModal> data) => GridView.builder(
//    primary: false,
//    shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(_context).orientation == Orientation.portrait ? 2 : 3,
        // 左右间隔
        crossAxisSpacing: 8,
        // 上下间隔
        mainAxisSpacing: 8,
        //宽高比 默认1
        childAspectRatio: 168 / 280,
      ),
//        shrinkWrap: true,
      itemCount: list.data.length,
//        children: data.map((product) {
      itemBuilder: (BuildContext context, int index) {
        var product = list.data[index];
        if ((index + 4) == list.data.length) {
          print(
              'SearchResultGridViewWidget.productGrid next page,current data count ${data.length},current index $index');
          getNextPage();
        }
        return Container(
//            color: Colors.blue ,
            child: Padding(
//                  padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
          padding: const EdgeInsets.all(0),
//            child: InkWell(
//              splashColor: Colors.yellow,
//        onDoubleTap: () => showSnackBar(),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.antiAlias,
//                      elevation: 2.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
//                        fit: StackFit.expand,
              children: <Widget>[
//                Expanded(
//                  child: ConstrainedBox(
//                    child: CachedNetworkImage(
//                      fadeInDuration: Duration(milliseconds: 0),
//                      fadeOutDuration: Duration(milliseconds: 0),
//                      fit: BoxFit.fill,
//                      imageUrl: product.imageUrl,
//                      width: 168,
//                      height: 168,
//                    ),
//                    constraints: new BoxConstraints.expand(),
//                  ),
//                ),
                CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeOutDuration: Duration(milliseconds: 0),
                  fit: BoxFit.fill,
                  imageUrl: product.imageUrl,
                  width: 168,
                  height: 168,
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 0, right: 8, bottom: 0),
                  child: Text(
                    product.wareName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Color(0xff333333)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '¥',
                      style: TextStyle(fontSize: 16, color: Color(0xFFfe2121)),
                    ),
                    Text(
                      '${(double.parse(product.price))}',
//                          '27.5',
                      style: TextStyle(fontSize: 18, color: Color(0xFFfe2121)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${product.commentcount}人评价',
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: 11, color: Color(0xFF999999)),
                      ),
                    ),
                    Text(
                      '100%好评',
                      style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '${product.shopName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF666666)),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('进店', style: TextStyle(fontSize: 11, color: Color(0xFF333333))),
                            Container(
                              alignment: Alignment.centerLeft,
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
                        )),
                  ],
                ),
//                SizedBox(
//                  height: 8,
//                )
              ],
            ),
//              ),
          ),
        ));
      });

//  );
}
