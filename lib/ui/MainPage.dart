import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ec/ui/home/HomePage.dart';
import 'package:flutter_ec/ui/message/MessagePage.dart';
import 'package:flutter_ec/ui/code/CodePage.dart';
import 'package:flutter_ec/ui/cart/CartPage.dart';
import 'package:flutter_ec/ui/mine/MinePage.dart';
import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/common/EcIcons.dart';

class EcMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            MessagePage(),
            CodePage(),
            CartPage(),
            MinePage()
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
              color: DColor.mf,
              border: Border(top: BorderSide(width: 1, color: DColor.divide))
          ),
          child: TabBar(
            indicatorWeight: 0.1,
            indicatorColor: DColor.mf,
            labelColor: DColor.main,
            labelStyle: TextStyle(
              height: 0,
              fontSize: 10,
            ),
            unselectedLabelColor: DColor.m6,
//            unselectedLabelStyle: TextStyle(
//              height: 0,
//              fontSize: 10,
//            ),
            tabs: <Widget>[
              Tab(
                text: '首页',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: '通知',
                icon: Icon(Icons.message),
              ),
//              SizedBox(),
              Tab(
//                text: '取证码',
                icon: Icon(EcIcons.icon_saoma),
              ),
              Tab(
                text: '购物车',
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                text: '我的',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
