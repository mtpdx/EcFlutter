import 'package:flutter/material.dart';

import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/ui/widget/FilterTab.dart';
import 'package:flutter_ec/ui/widget/SearchResultGridView.dart';
import 'package:flutter_ec/ui/widget/SearchResultListView.dart';
import 'package:flutter_ec/common/entity/Search.dart';
import 'package:flutter_ec/common/service/search.dart';

class SearchGoodsResultPage extends StatefulWidget {
  SearchGoodsResultPage({Key key, this.searchKey}) : super(key: key);
  final String searchKey;

  @override
  _SearchGoodsResultPageState createState() {
    return _SearchGoodsResultPageState();
  }
}

class _SearchGoodsResultPageState extends State<SearchGoodsResultPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin{
  int page = 0;
  bool showGrid = true;
  int filterTag = 0;
  SearchResultListModal listData = SearchResultListModal([]);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getSearchList(widget.searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
//              bottomOpacity: 0,
//              toolbarOpacity: 0,
            brightness: Brightness.light,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Container(
        color: DColor.mf,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 6,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: DColor.m9,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
//      margin: EdgeInsets.only(left: 16, right: 16),
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: DColor.bg),
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 4, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: DColor.m9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${widget.searchKey}',
                                style:
                                    TextStyle(fontSize: 14, color: DColor.mf),
                              ),
                              Icon(
                                Icons.close,
                                size: 12,
                                color: DColor.mf,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              height: 48,
              color: DColor.mf,
              child: FilterTab(
                onTabChangedListener: (position) {},
                onTabStyleChangedListener: (position) {
                  setState(() {
                    showGrid = !showGrid;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                  color: DColor.bg,
//                  padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  child: NotificationListener(
                    onNotification: _onScroll,
                    child: showGrid ? SearchResultGridView(listData, getNextPage: () => _getSearchList(widget.searchKey))
                        : SearchResultListView(listData, getNextPage: () => _getSearchList(widget.searchKey)),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onScroll(Notification notification) {

  }

  void _getSearchList(String searchKey) async{
    var data = await getSearchResult(searchKey, page++);
    SearchResultListModal list = SearchResultListModal.fromJson(data);
    if (mounted) {
      setState(() {
        listData.data.addAll(list.data);
      });
    }
  }
}
