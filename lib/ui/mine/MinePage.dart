import 'package:flutter/material.dart';
import 'package:flutter_ec/common/entity/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ec/common/EcIcons.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List<Goods> goodsList = [];
  ScrollController _controller;
  bool _isLoding = false;
  bool _isRefreshing = false;
  String loadingText = "加载中.....";
  int page = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    goodsList = HomeTestData().getTestGoods(tag: 'init');
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
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
//              bottomOpacity: 0,
//              toolbarOpacity: 0,
//            brightness: Brightness.light,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Container(
        color: Color(0xfff5f5f5),
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
                    goodsList
                        .addAll(HomeTestData().getTestGoods(tag: 'load$page'));
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
              slivers: [
                SliverPersistentHeader(
                  delegate: MineSliverAppBar(expandedHeight: 192),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(left: 16, right: 16),
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  '我的服务',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff333333)),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Color(0xfff5f5f5),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _buildServerITBtn('联系客服', EcIcons.icon_kefu),
                              _buildServerITBtn('收货地址', EcIcons.icon_weizhi),
                              _buildServerITBtn(
                                  '意见反馈', EcIcons.icon_liuyanpinglun),
                              _buildServerITBtn('关于我们', EcIcons.icon_diannaodianqi),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 56,
                    child: Center(
                      child: Text(
                        '专属推荐',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ),

//                SliverToBoxAdapter(
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 16, right: 16),
//                    child: GridView.builder(
//                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 2,
//                        crossAxisSpacing: 8,
//                        mainAxisSpacing: 8,
//                        childAspectRatio: 168 / 260,
//                      ),
//                      itemCount: goodsList.length,
//                      itemBuilder:(BuildContext context, int index){
//                        return GridGoodsV(
//                          goods: goodsList[index],
//                        );
//                      }),
//                  ),
//                ),

                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    childAspectRatio: 168 / 240,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Goods goods = goodsList[index];
                      return Container(
                          margin: (index % 2 == 0)
                              ? EdgeInsets.only(left: 16)
                              : EdgeInsets.only(right: 16),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(8)),
//                          color: Color(0xffffffff),
//                        ),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    '${goods.title}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    '${goods.price}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xfffe2121),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
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

  Widget _buildServerITBtn(String title, IconData iconDaTa) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconDaTa,
          size: 24,
          color: Color(0xff666666),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '$title',
          style: TextStyle(fontSize: 14, color: Color(0xff666666)),
        ),
      ],
    );
  }
}

class MineSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MineSliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    print('$shrinkOffset,   $overlapsContent');
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
//        Image.network(
//          "https://besthqwallpapers.com/Uploads/9-10-2018/68475/thumb2-4k-creative-art-red-background-lines-geometry.jpg",
//          fit: BoxFit.cover,
//        ),
        Container(
          decoration: BoxDecoration(
            color: _gradientColor(expandedHeight, shrinkOffset, [254, 33, 33], [255, 255, 255]),
//            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28))
          ),
        ),
        Offstage(
          offstage: shrinkOffset > expandedHeight*3/5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: Image.asset(
                              'images/git.jpg',
                              fit: BoxFit.fill,
                            ).image)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: expandedHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hi Sunyh',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          '可船都终要停泊 船长也难免会离开',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Offstage(
          offstage: shrinkOffset > expandedHeight*3/5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildTBtn('收藏夹', '0'),
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.white,
                  ),
                  _buildTBtn('关注', '4'),
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.white,
                  ),
                  _buildTBtn('浏览足迹', '6'),
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.white,
                  ),
                  _buildTBtn('优惠券', '0'),
                ],
              ),
            ),
          ),
        ),

//        Positioned(
//          bottom: 0,
//          child: Opacity(
//            opacity: shrinkOffset / expandedHeight,
//            child: Container(
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  border: Border(
//                      bottom: BorderSide(width: 1, color: Color(0xffffffff)))),
//              height: kMinInteractiveDimension,
//              width: MediaQuery.of(context).size.width,
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Expanded(
//                    child: SizedBox(),
//                  ),
//                  Icon(
//                    Icons.settings,
//                    color: Color(0xff333333),
//                    size: 18,
//                  ),
//                  SizedBox(
//                    width: 16,
//                  )
//                ],
//              ),
//            ),
//          ),
//        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "个人中心",
              style: TextStyle(
                color: Color(0xff333333),
//                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight * 3 / 4 - shrinkOffset,
//          left: MediaQuery.of(context).size.width / 4,
          left: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              padding: EdgeInsets.all(0),
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              width: MediaQuery.of(context).size.width - 32,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            '我的订单',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff333333)),
                          ),
                        ),
                        Text(
                          '查看全部订单  >',
                          style:
                              TextStyle(color: Color(0xff999999), fontSize: 12),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Color(0xfff5f5f5),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildOrderITBtn(
                            '待付款', EcIcons.icon_qianbao, '2'),
                        _buildOrderITBtn('待发货', EcIcons.icon_zhangdan, '20'),
                        _buildOrderITBtn('待收货', EcIcons.icon_xiaohuoche, ''),
                        _buildOrderITBtn('退货退款', EcIcons.icon_duihui, '99+'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 16,
//          left: MediaQuery.of(context).size.width / 4,
            right: 16,
            child: Opacity(
              opacity: 1,
              child: Icon(
                EcIcons.icon_shezhi,
                color: _gradientColor(expandedHeight, shrinkOffset, [255,255,255],[51,51,51]),
                size: 18,
              ),
            )
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kMinInteractiveDimension;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _buildOrderITBtn(String title, IconData icon, String num) {
    return Container(
      height: 60,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 24,
                color: Color(0xff666666),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '$title',
                style: TextStyle(fontSize: 14, color: Color(0xff666666)),
              ),
            ],
          ),
          num.length > 0
              ? Positioned(
                  top: 0,
                  left: 24,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xfffe2121),
                    ),
                    child: Text(
                      '$num',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    margin: EdgeInsets.only(right: 10),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildTBtn(String title, String num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$num',
          style: TextStyle(fontSize: 12, color: Color(0xffffffff)),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$title',
          style: TextStyle(fontSize: 12, color: Color(0xffffffff)),
        ),
      ],
    );
  }

  Color _gradientColor(double step, double offset, List<int> startRGB, List<int> endRGB) {
    var startR = startRGB[0];
    var startG = startRGB[1];
    var startB = startRGB[2];

    var endR = endRGB[0];
    var endG = endRGB[1];
    var endB = endRGB[2];

    var sR = (endR-startR)/step;//总差值
    var sG = (endG-startG)/step;
    var sB = (endB-startB)/step;
    
    var cR = startR + sR*offset;
    var cG = startG + sG*offset;
    var cB = startB + sB*offset;
    return Color.fromARGB(255, cR.toInt(), cG.toInt(), cB.toInt());
  }
}
