import 'package:flutter/material.dart';
import 'package:flutter_ec/common/Color.dart';

import 'package:flutter_ec/ui/home/HomeIndexPage.dart';
import 'package:flutter_ec/ui/home/HomeJxPage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_ec/common/entity/Home.dart';
import 'package:flutter_ec/ui/home/SearchGoodsPage.dart';
import 'package:flutter_ec/common/EcIcons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Choice> choices = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      choices = HomeTabData().getHomeTab();
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DColor.main,
          title: SearchView(),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: '扫一扫');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EcIcons.icon_saoma,
                      size: 18,
                      color: DColor.mf,
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '扫一扫',
                      style: TextStyle(fontSize: 9, color: DColor.mf),
                    ),
                  ],
                ),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: DColor.mf,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: choices.map<Widget>((Choice choice) {
              return Tab(
                text: choice.title,
//                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map<Widget>((Choice choice) {
            return choice.id == 0
                ? HomeJxPage(id: choice.id)
                : HomeIndexPage(id: choice.id);
          }).toList(),
        ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  final String searchKey  = '耳机';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SearchGoodsPage(searchKey: searchKey);
        })).then((val) {
          // 详情页面返回时传递过来的参数
          print(val);
        });
      },
      child: Container(
//      margin: EdgeInsets.only(left: 16, right: 16),
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            color: DColor.mf),
        height: 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 20,
              color: DColor.m9,
            ),
            Text(
              '$searchKey',
              style: TextStyle(fontSize: 14, color: DColor.m9),
            ),
          ],
        ),
      ),
    );
  }
}
