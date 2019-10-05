import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_ec/ui/widget/pull_load/ListState.dart';
import 'package:flutter_ec/ui/widget/pull_load/PullLoadWidget.dart';
import 'package:flutter_ec/ui/cart/ShoppingCarItemWidget.dart';
import 'package:flutter_ec/ui/cart/ShoppingCardModel.dart';
import 'package:flutter_ec/ui/cart/ShoppingCartData.dart';
import 'package:flutter_ec/ui/cart/CheckBox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ec/common/Color.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage>
    with
        AutomaticKeepAliveClientMixin<CartPage>,
        ListState<CartPage>,
        WidgetsBindingObserver {
  Gradient _mainGradient =
      const LinearGradient(colors: [DColor.main, DColor.re2]);
  static Gradient primaryGradient =
      const LinearGradient(colors: [DColor.re2, DColor.re1]);
  bool _isAllSelected = false;

  GlobalKey _keyFilter = GlobalKey();
  double _firstItemHeight = 0;

  double _lastScrollPixels = 0;
  bool _isShowFloatingTopBar = true;
  double _topBarOpacity = 1;

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
    _getSizes('_keyFilter', _keyFilter);
  }

  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of $log: $positionRed ");
  }

  _getSizes(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var sizeRed = renderBoxRed.size;
    print("SIZE of $log: $sizeRed");

    setState(() {
      _firstItemHeight = sizeRed.height;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context); // 如果不加这句，从子页面回来会重新加载didChangeDependencies()方法

    var firstItemWidget = ShoppingCarItemWidget(
      shoppingCartModels[0],
      color: Colors.transparent,
      addTap: (orderModel) {
        if (orderModel.quantity + 1 > orderModel.amountPurchasing) {
          Fluttertoast.showToast(
              msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
        } else {
          setState(() {
            orderModel.quantity++;
          });
        }
      },
      removeTap: (orderModel) {
        if (orderModel.quantity == 1) {
          Fluttertoast.showToast(
              msg: '受不了了，宝贝不能再减少了哦', gravity: ToastGravity.CENTER);
        } else {
          setState(() {
            orderModel.quantity--;
          });
        }
      },
      onSelectAllChanged: (value) {
        setState(() {
          shoppingCartModels[0].isSelected = value;
          shoppingCartModels[0].orderModels.forEach((item) {
            item.isSelected = value;
          });
        });
      },
      onSelectChanged: (orderModel, value) {
        setState(() {
          orderModel.isSelected = value;
//                shoppingCartModel.isSelected=value;
        });
      },
    );

    var testWidget = Container(
        color: DColor.re2,
        key: _keyFilter,
//      height: _firstItemHeight + 50,
        child: firstItemWidget);

//    return testWidget;

    var pullLoadWidget = PullLoadWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) {
        ShoppingCartModel shoppingCartModel =
            pullLoadWidgetControl.dataList[index];
        print('$index');
//        if (index == 0) {
//          return Container(
//              color: Color(0xfff5f5f5),
////          color: Colors.red,
//              height: _firstItemHeight + 48 + ScreenUtil.statusBarHeight + 20,
//              child: TopItem(
//                  topBarOpacity: _topBarOpacity,
//                  contentWidgetHeight: _firstItemHeight,
////contentWidget: Container(height: 44,color: Colors.white,width: 100,),
//                  contentWidget: Container(
//                      child: ShoppingCarItemWidget(
//                    shoppingCartModels[0],
//                    color: Colors.transparent,
//                    addTap: (orderModel) {
//                      if (orderModel.quantity + 1 >
//                          orderModel.amountPurchasing) {
//                        Fluttertoast.showToast(
//                            msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
//                      } else {
//                        setState(() {
//                          orderModel.quantity++;
//                        });
//                      }
//                    },
//                    removeTap: (orderModel) {
//                      if (orderModel.quantity == 1) {
//                        Fluttertoast.showToast(
//                            msg: '受不了了，宝贝不能再减少了哦',
//                            gravity: ToastGravity.CENTER);
//                      } else {
//                        setState(() {
//                          orderModel.quantity--;
//                        });
//                      }
//                    },
//                    onSelectAllChanged: (value) {
//                      setState(() {
//                        shoppingCartModels[0].isSelected = value;
//                        shoppingCartModels[0].orderModels.forEach((item) {
//                          item.isSelected = value;
//                        });
//                      });
//                    },
//                    onSelectChanged: (orderModel, value) {
//                      setState(() {
//                        orderModel.isSelected = value;
////                shoppingCartModel.isSelected=value;
//                      });
//                    },
//                  ))));
//        } else {
        return ShoppingCarItemWidget(
          shoppingCartModel,
          addTap: (orderModel) {
            if (orderModel.quantity + 1 > orderModel.amountPurchasing) {
              Fluttertoast.showToast(
                  msg: '该宝贝不能购买更多哦', gravity: ToastGravity.CENTER);
            } else {
              setState(() {
                orderModel.quantity++;
              });
            }
          },
          removeTap: (orderModel) {
            if (orderModel.quantity == 1) {
              Fluttertoast.showToast(
                  msg: '受不了了，宝贝不能再减少了哦', gravity: ToastGravity.CENTER);
            } else {
              setState(() {
                orderModel.quantity--;
              });
            }
          },
          onSelectAllChanged: (value) {
            setState(() {
              shoppingCartModel.isSelected = value;
              shoppingCartModel.orderModels.forEach((item) {
                item.isSelected = value;
              });
            });
          },
          onSelectChanged: (orderModel, value) {
            setState(() {
              orderModel.isSelected = value;
//                shoppingCartModel.isSelected=value;
            });
          },
        );
//        }
      },
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );

    var body = Container(
      decoration: BoxDecoration(
        gradient: _mainGradient,
      ),
      child: MediaQuery.removePadding(
        removeTop: true,
//        child: NotificationListener<ScrollNotification>(
//            onNotification: _onScroll,
            child: pullLoadWidget,
//            child: Scrollbar(
//                child: Stack(
//              children: <Widget>[
//                Container(
//                  child: pullLoadWidget,
//                ),
//                Offstage(
//                  offstage: !_isShowFloatingTopBar,
//                  child: Container(
//                    decoration: BoxDecoration(gradient: primaryGradient),
//                    height: 48.0 + ScreenUtil.statusBarHeight,
//                    width: ScreenUtil.screenWidth,
////                margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(
//                          height: ScreenUtil.statusBarHeight,
//                        ),
//                        Container(
//                          height: 48,
//                          child: _buildFloatingTopBar(),
//                        )
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ))
//        ),
        context: context,
      ),
    );

    double totalAmount = 0;
    int settlementCount = 0;
    for (var value1 in shoppingCartModels) {
      for (var value in value1.orderModels) {
        if (value.isSelected) {
          totalAmount += value.price * value.quantity;
          settlementCount++;
        }
      }
    }

    return SafeArea(
      child: Column(
        children: <Widget>[
          Offstage(
            child: testWidget,
            offstage: true,
          ),
          AppBar(
            backgroundColor: DColor.main,
            centerTitle: true,
            elevation: 1,
            title: Text('购物车',style: TextStyle(color: DColor.mf),),
            actions: <Widget>[
              GestureDetector(
                onTap: (){

                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16, top: 16),
                  child: Text(
                    '编辑',
                    style: TextStyle(
//                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: DColor.mf
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: body,
          ),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: DColor.mf,
              border:
                  Border(top: BorderSide(color: Color(0xFFededed), width: .3)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GZXCheckbox(
                    value: _isAllSelected,
                    onChanged: (value) {
                      setState(() {
                        _isAllSelected = value;
                        shoppingCartModels.forEach((item) {
                          item.isSelected = value;
                          item.orderModels.forEach((i) {
                            i.isSelected = value;
                          });
                        });
                      });
                    },
                    spacing: 6,
                    descriptionWidget: Text(
                      '全选',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                    ),
                  ),
                ),
                totalAmount == 0
                    ? Container()
                    : Text(
                        '已包邮',
                        style: TextStyle(color: Color(0xFF666666), fontSize: 9),
                      ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '合计:',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '¥',
                  style: TextStyle(fontSize: 16, color: Color(0xFFfe2121)),
                ),
                Text(
                  '${(totalAmount)}',
                  style: TextStyle(fontSize: 16, color: Color(0xFFfe2121)),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 36,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: DColor.main,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Text(
                    '结算($settlementCount)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
      top: false,
    );
  }


//  Widget _buildFloatingTopBar({int productNum = 0}) {
//    var list =
//        shoppingCartModels.map((item) => item.orderModels.length).toList();
//    var count = list.reduce((value, element) {
//      print('reduce $value  $element}');
//      return value + element;
//    });
//    return Stack(
//      children: <Widget>[
//        Container(
////          color: Colors.blue,
//          alignment: Alignment.center,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              GestureDetector(
//                  child: Text(
//                '编辑',
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              )),
//              SizedBox(
//                width: 8,
//              ),
//            ],
//          ),
//        ),
//        Center(
//          child: Text(
//            count == 0 ? '购物车' : '购物车(${count})',
//            textAlign: TextAlign.center,
//            style: TextStyle(fontSize: 18, color: Colors.white),
//          ),
//        ),
//      ],
//    );
//  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    WidgetsBinding.instance.addObserver(this);

    pullLoadWidgetControl.dataList = shoppingCartModels;
//    getIndexListData(1);
    setState(() => {pullLoadWidgetControl.needLoadMore = false});
  }

  getIndexListData(page) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        pullLoadWidgetControl.dataList = shoppingCartModels;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    // 紧跟在initState之后调用
    super.didChangeDependencies();
  }

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    await getIndexListData(page);
    setState(() {
      pullLoadWidgetControl.needLoadMore = false;
    });
    isLoading = false;

    return null;
  }

  @override
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    await getIndexListData(page);
    setState(() {
      pullLoadWidgetControl.needLoadMore = page > 3;
    });
    isLoading = false;
    return null;
  }
}

//class TopItem extends StatelessWidget {
//  final bool isShowFloatingTopBar;
//  final double topBarOpacity;
//  final int productNum;
//  final Widget contentWidget;
//  final double contentWidgetHeight;
//  double _topBarHeight = 48;
//  static Gradient primaryGradient =
//      const LinearGradient(colors: [DColor.re2, DColor.re1]);
//
//  TopItem(
//      {Key key,
//      this.isShowFloatingTopBar = false,
//      this.topBarOpacity = 1,
//      this.productNum = 0,
//      this.contentWidget,
//      this.contentWidgetHeight})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: Stack(children: <Widget>[
//      Container(
//        child: Container(
//          decoration: new BoxDecoration(
//            gradient: primaryGradient,
//          ),
////                color: Theme.of(context).primaryColor,
//          width: ScreenUtil.screenWidth,
//          height: ScreenUtil.screenHeight / 4,
//        ),
//      ),
//      Opacity(
//        opacity: topBarOpacity,
//        child: Container(
//          height: _topBarHeight,
//          margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
////          color: Colors.red,
//          child: _buildTopBar(),
//        ),
//      ),
//      Positioned(
//          top: _topBarHeight + ScreenUtil.statusBarHeight,
//          child: Opacity(
//            opacity: topBarOpacity,
//            child: Row(
//              children: <Widget>[
//                SizedBox(
//                  width: 8,
//                ),
//                Text(
//                  '共${productNum}件宝贝',
//                  style: TextStyle(color: Colors.white, fontSize: 12),
//                ),
//                SizedBox(
//                  width: 10,
//                ),
//              ],
//            ),
//          )),
//
////Container(height: 367,child: contentWidget,)
//      Positioned(
//          top: _topBarHeight + ScreenUtil.statusBarHeight + 30,
//          height: contentWidgetHeight,
//          width: ScreenUtil.screenWidth,
//          child: contentWidget)
//    ]));
//  }
//
//  Widget _circleButton(
//      Color imageBackgroundColor, IconData iconData, text, int unreadMessages) {
//    return Container(
////      color: Colors.red,
//      width: 50,
//      child: GestureDetector(
//        child: Stack(
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
////        mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundColor: imageBackgroundColor,
//                  radius: 22,
//                  child: Icon(
//                    iconData,
//                    color: Colors.white,
//                  ),
//                ),
//                SizedBox(
//                  height: 4,
//                ),
//                Text(
//                  text,
//                  style: TextStyle(
//                    fontSize: 10,
//                    color: Color(0xFF6a6a6a),
//                  ),
//                )
//              ],
//            ),
//            Positioned(
//              top: 10,
//              right: 0,
//              child: Container(
////                width: 18.0,
////                height: 18.0,
//                alignment: Alignment.center,
//                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
//                decoration: BoxDecoration(
//                    border: Border.all(color: Colors.white, width: 1),
//                    borderRadius: BorderRadius.circular(20 / 2.0),
//                    color: Color(0xffff3e3e)),
//                child: Text(
//                  '${unreadMessages}',
//                  style: TextStyle(
//                      fontSize: 12.0,
//                      fontWeight: FontWeight.bold,
//                      color: Color(0xffffffff)),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildTopBar() {
//    return Row(
//      children: <Widget>[
//        SizedBox(
//          width: 8,
//        ),
//        Expanded(
//          child: Text(
//            '购物车',
//            style: TextStyle(
//                fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
//          ),
//        ),
//        GestureDetector(
//            onTap: () {
////            Fluttertoast.showToast(msg: '受不了了，宝贝不能再减少了哦');
//            },
//            child: Text(
//              '编辑',
//              style: TextStyle(
//                color: Colors.white,
//              ),
//            )),
//        SizedBox(
//          width: 8,
//        ),
//      ],
//    );
//  }
//}
