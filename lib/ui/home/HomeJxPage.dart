import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/common/entity/Home.dart';
import 'package:flutter_ec/ui/widget/GridGoodsV.dart';
import 'package:flutter_ec/ui/widget/FilterTab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class HomeJxPage extends StatefulWidget {
  HomeJxPage({Key key, @required this.id}) : super(key: key);
  final int id;

  @override
  _HomeJxPageState createState() => _HomeJxPageState();
}


class _HomeJxPageState extends State<HomeJxPage> {
  List<String> bannerList = [
    'https://hbimg.huabanimg.com/54eb9bf4ab32fc2ec87d7cf7723770ff76984df4225f6-RPItmu_fw658',
    'https://i.pinimg.com/originals/50/48/65/5048656c5304d1cb0dcb0fc5fd982fad.jpg',
    'https://about.canva.com/wp-content/uploads/sites/3/2015/02/Etsy-Banners.png'
  ];

  List<Goods> goodsList = [];
  List<Goods> horGoodsList = [];

  ScrollController _controller;

  bool _isLoding = false;
  bool _isRefreshing = false;
  String loadingText = "加载中.....";
  int page = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    setState(() {
      goodsList = HomeTestData().getTestGoods(tag: 'init');
      horGoodsList = HomeTestData().getTestGoods();
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
                        HomeTestData().getTestGoods(tag: 'load${page}'));
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
                    child: new Swiper(
                      scrollDirection: Axis.horizontal,
                      loop: true,
                      autoplay: true,
                      onTap: (index) {},
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              placeholder: "images/green.jpg",
                              image:
                                  '${bannerList[index]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      itemCount: bannerList.length,
                      pagination: new SwiperPagination(),
//                      control: new SwiperControl(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 44,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0x99fe2318),
                                ),
                                child: Text(
                                  '通知',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: 11, color: DColor.mf),
                                ),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text(
                                '你有最新的物流消息,点击查看',
                                style:
                                    TextStyle(fontSize: 11, color: DColor.m6),
                              )
                            ],
                          ),
                        ),
                        Text(
                          '|  更多   ',
                          style: TextStyle(
                            fontSize: 11,
                            color: DColor.m9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    childAspectRatio: 168 / 260,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GridGoodsV(
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
