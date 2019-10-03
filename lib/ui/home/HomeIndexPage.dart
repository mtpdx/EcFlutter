import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/common/entity/Home.dart';
import 'package:flutter_ec/ui/widget/GridGoodsV.dart';
import 'package:flutter_ec/ui/widget/ListGoodsV.dart';
import 'package:flutter_ec/ui/widget/FilterTab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class HomeIndexPage extends StatefulWidget {
  HomeIndexPage({Key key, @required this.id}) : super(key: key);
  final int id;

  @override
  _HomeIndexPageState createState() => _HomeIndexPageState();
}

class _SliverFilterTabDelegate extends SliverPersistentHeaderDelegate {
  _SliverFilterTabDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _HomeIndexPageState extends State<HomeIndexPage> {

  List<Goods> goodsList = [];
  List<Goods> horGoodsList = [];
  List<Cate> cateList = [];

  ScrollController _controller;

  bool _isLoding = false;
  bool _isRefreshing = false;
  String loadingText = "加载中.....";
  int page = 0;
  bool showGrid = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    setState(() {
      goodsList = HomeTestData().getTestGoods(tag: 'init');
      horGoodsList = HomeTestData().getTestGoods();
      cateList = HomeCateData().getHomeCateOne();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String> _refreshPull() async {
    await Future.delayed(new Duration(seconds: 3));
    return "_RrefreshPull";
  }

  onFilterTabStyleChanged(position){
    if((showGrid && position == 1) || (!showGrid && position == 0)){
      setState(() {
        showGrid = !showGrid;
        Fluttertoast.showToast(msg: "showGrid: $showGrid");
      });
    }
  }

  onFilterTabChanged(position) {
    Fluttertoast.showToast(msg: "current position : $position");
    setState(() {
      page = 0;
      if (position == 0) {
        goodsList = HomeTestData().getTestGoods(tag: 'common ');
      } else if (position == 1) {
        goodsList = HomeTestData().getTestGoods(tag: 'sale ');
      } else if (position == 2) {
        goodsList = HomeTestData().getTestGoods(tag: 'price up ');
      } else if (position == 3) {
        goodsList = HomeTestData().getTestGoods(tag: 'pride down ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: DColor.bg,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification &&
                notification.depth == 0 &&
                !_isLoding &&
                !_isRefreshing) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
                setState(() {
                  _isLoding = true;
                  loadingText = "加载中.....";
                });
                _refreshPull().then((value) {
                  print('加载成功.............');
                  setState(() {
                    _isLoding = false;
                    page++;
                    goodsList.addAll(
                        HomeTestData().getTestGoods(tag: 'load$page'));
                  });
                }).catchError((error) {
                  print('failed');
                  setState(() {
                    _isLoding = true;
                    loadingText = "加载失败.....";
                  });
                });
              }
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () {
              // 下拉刷新
              if (_isLoding) return null;
              return _refreshPull().then((value) {
                print('success');
                setState(() {
                  page = 0;
                  goodsList = HomeTestData().getTestGoods(tag: 'refresh');
                });
              }).catchError((error) {
                print('failed');
              });
            },
            child: CustomScrollView(
              controller: _controller,
              physics: ScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(height: 6,),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 135,

//                    decoration: BoxDecoration(
//                      color: DColor.re2,
//                      borderRadius: BorderRadius.all(Radius.circular(8)),
//                    ),
                    child: new Swiper(
                      scrollDirection: Axis.horizontal,
                      loop: true,
                      onTap: (index) {},
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              placeholder: "images/green.jpg",
                              image:
                              'https://about.canva.com/wp-content/uploads/sites/3/2015/02/Etsy-Banners.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      itemCount: 3,
                      pagination: new SwiperPagination(),
//                      control: new SwiperControl(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(height: 6,),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 75 / 100,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Cate cate = cateList[index];
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          decoration: BoxDecoration(
//                            borderRadius:
//                            BorderRadius.all(Radius.circular(8)),
                            color: DColor.mf,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 48,
                                height: 48,
                                child: Image(
                                  image: NetworkImage(cate.imgUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text(
                                  '${cate.title}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: DColor.m3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: cateList.length,
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverFilterTabDelegate(
                    minHeight: 48.0,
                    maxHeight: 48.0,
                    child: Container(
                      color: DColor.bg,
                      child: FilterTab(
                        onTabChangedListener: onFilterTabChanged,
                        onTabStyleChangedListener: onFilterTabStyleChanged,
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: showGrid ? 2 : 1,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    childAspectRatio: showGrid ? (168 / 260): (318 / 140),
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return showGrid ? GridGoodsV(
                        goods: goodsList[index],
                      ) : ListGoodsV(
                        goods: goodsList[index],
                      );
                    },
                    childCount: goodsList.length,
                  ),
                ),
                new SliverToBoxAdapter(
                  child: new Visibility(
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: new Center(
                        child: new Text(loadingText),
                      ),
                    ),
                    visible: _isLoding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
