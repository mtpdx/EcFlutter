import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_ec/common/Color.dart';
import 'package:flutter_ec/ui/widget/gzx_search_card.dart';
import 'package:flutter_ec/ui/home/SearchGoodsResultPage.dart';
import 'package:flutter_ec/common/EcIcons.dart';

class SearchGoodsPage extends StatefulWidget{
  SearchGoodsPage({Key key, this.searchKey}):super(key: key);
  String searchKey;

  @override
  _SearchGoodsPageState createState() {
    return _SearchGoodsPageState();
  }

}

class _SearchGoodsPageState extends State<SearchGoodsPage>{
  List<String> recommendWords = [];
  List<String> searchRecordTexts = [];
  TextEditingController _keywordsTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _keywordsTextEditingController.text = widget.searchKey;
    if (widget.searchKey != null) {
      searchTxtChanged(widget.searchKey);
    }

    initSearchRecord();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColor.mf,
      appBar: AppBar(
        backgroundColor: DColor.mf,
        centerTitle: true,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child:Icon(
              EcIcons.icon_fanhuijiantou,
              size: 24,
              color: DColor.m9,
            )
          ),
        ),
        title: GZXSearchCardWidget(
          elevation: 0,
          autofocus: true,
          textEditingController: _keywordsTextEditingController,
          isShowLeading: false,
          onSubmitted: (value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SearchGoodsResultPage(searchKey: value);
            })).then((val) {
              print(val);
            });
          },
          onChanged: (value) {
            searchTxtChanged(value);
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SearchGoodsResultPage(searchKey: widget.searchKey);
              })).then((val) {
                print(val);
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16, top: 16),
              child: Text(
                '搜索',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: DColor.main
                ),
            ),
            ),
          ),
        ],
      ),
      body: Container(
       child: recommendWords.length == 0 ? _buildHotkeyWidget() : _buildRecommendWidget(),
      ),
    );
  }

  void searchTxtChanged(String searchKey) async{
    widget.searchKey = searchKey;
    try{
      Dio dio = new Dio();
      Response response = await dio.get(
          'https://suggest.taobao.com/sug?code=utf-8&q=$searchKey&k=1&area=c2c');
      Map responseData = jsonDecode(response.toString());
//      print(responseData);
      var xx = responseData['result'] as List;
      List<String> xs = [];
      xx.forEach((item){
        xs.add(item[0] as String);
      });
      setState(() {
        recommendWords = xs;
      });
    }catch(err){
      print(err);
    }
  }

  Widget _buildRecommendWidget() {
    var listView = ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 6),
      itemCount: recommendWords.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SearchGoodsResultPage(searchKey: recommendWords[i]);
            })).then((val) {
              print(val);
            });
          },
          child: Container(
//            color: Colors.white,
            height: 42,
//            width: double.infinity,
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            // constraints: BoxConstraints(minWidth: double.infinity),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    recommendWords[i],
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Container(
          height: 1,
          color: Colors.grey[200],
        );
      },
    );

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white),
//      color: Colors.red,
        child: listView);
  }

  Widget _buildHotkeyWidget() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                '历史记录',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: DColor.m3
                ),
              ),
            ),
            Icon(
              Icons.delete_outline,
              color: Colors.grey,
              size: 16,
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: searchRecordTexts
              .map((item) => GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SearchGoodsResultPage(searchKey: item);
              })).then((val) {
                print(val);
              });
            },
            child: Container(
//                    height: 26,
//                          padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
                decoration: BoxDecoration(
//                    color: randomColor(),
                    color: DColor.bg,
                    borderRadius: BorderRadius.circular(14)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  item,
                  style: TextStyle(color: DColor.m3, fontSize: 12),
                )),
          ))
              .toList(),
        ),

      ],
    );
  }

  void initSearchRecord() {
    searchRecordTexts = [
      '棉衣',
      '蓝牙耳机',
      '洗碗机家用',
      '酸奶',
      '面包',
      '一加 手机',
      '三只松鼠',
      '机械键盘',
      '老路小路',
    ];
  }

}