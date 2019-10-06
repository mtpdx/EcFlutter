import 'package:flutter/material.dart';

class Goods {
  const Goods({this.title, this.imgUrl, this.price});

  final String title;
  final String imgUrl;
  final String price;
}

class Choice {
  const Choice({this.title, this.id});

  final String title;
  final int id;
}

class Cate {
  const Cate({this.title, this.imgUrl});

  final String title;
  final String imgUrl;
}

class HomeCateData{
  List<Cate> getHomeCateOne() => <Cate>[
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'单反相机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t26179/362/900967/280508/457b79f4/5b7fc70cN8375576f.jpg'),
    Cate(title:'智能手环', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/71446/40/5294/212027/5d37ccdbEc60139a9/04dbe3b30329f01b.jpg'),
    Cate(title:'蓝牙耳机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t10915/325/2901316976/104238/84c0fe4f/5cdcc911Nd1d8d6dd.jpg'),
    Cate(title:'机械键盘', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t12286/212/886786636/63634/91ed8424/5a1665d3N85a556ed.jpg'),
    Cate(title:'游戏机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t24280/355/809346995/58119/d9407f0e/5b442f74N23caa058.jpg'),
    Cate(title:'智能音箱', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/31784/25/9843/215961/5caabb7cE1798332d/d1fa17bc9f379ad1.jpg'),
    Cate(title:'笔记本', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/35567/12/9049/159863/5ce4ba08E37d5378f/46b76a72f0e1ba87.jpg'),
    Cate(title:'台式机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/27614/11/4706/248452/5c345023Ef41760c7/687169631ae19453.jpg'),
    Cate(title:'更多', imgUrl:'http://bpic.588ku.com/element_pic/01/35/70/59573bf1168c651.jpg'),
  ];
}

class HomeTabData{
  List<Choice> getHomeTab() => <Choice>[
    Choice(title: '精选', id: 0),
    Choice(title: '数码', id: 1),
    Choice(title: '女装', id: 2),
    Choice(title: '鞋包', id: 3),
    Choice(title: '户外', id: 4),
    Choice(title: '美妆', id: 5),
    Choice(title: '电器', id: 6),
    Choice(title: '个护', id: 7),
  ];
}

class HomeTestData {
//  HomeTestData({this.tag: ''});
//  final String tag;
  List<Goods> getTestGoods({tag: ""}){
    return [
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7骁龙855旗舰性能曜岩灰全面屏拍照智能游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/35032/13/9593/102096/5cf0c2ccE77dc890e/abde5c9a60044485.jpg',
          price: '¥2799.00'),
      Goods(
          title:
          '${tag}一加云耳2磁吸入耳式无线运动蓝牙线控耳机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t10915/325/2901316976/104238/84c0fe4f/5cdcc911Nd1d8d6dd.jpg',
          price: '¥599.00'),
      Goods(
          title:
          '${tag}一加休闲Explorer双肩包男女书包电脑包双肩背包',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t27823/363/1853982255/177857/7492eb4c/5bee99f1N40170ade.jpg',
          price: '¥499.00'),
      Goods(
          title:
          '${tag}一加云耳 蓝牙无线 入耳式运动耳机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t20341/91/756223498/52120/e9552e08/5b1786faN6e75413c.jpg',
          price: '¥299.00'),
      Goods(
          title:
          '${tag}一加手机7 Pro 尼龙全包保护壳（黑色）',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t29461/44/1491229760/140925/391f712f/5ce16029Nd3a9d473.jpg',
          price: '¥149.00'),
      Goods(
          title:
          '${tag}一加原装Warp闪充充电器30W电源适配器（中规）',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t28408/335/1501693565/96071/b67a76fb/5ce28662Naa8a8a79.jpg',
          price: '¥109.00'),
      Goods(
          title:
          '${tag}一加Warp闪充5A充电线Type-C数据线（150cm）',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s843x843_jfs/t28141/362/1520779319/272500/31a0dc83/5ce2573aN3f41fc84.jpg',
          price: '¥99.00'),
      Goods(
          title:
          '${tag}一加 车载DASH闪充',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t8353/7/50891640/46218/d604fcd6/599fc2deNd8d30898.jpg',
          price: '¥199.00'),
    ];
  }
}

