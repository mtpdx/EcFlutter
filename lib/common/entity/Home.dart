import 'package:flutter/material.dart';

class Goods {
  const Goods({this.title, this.imgUrl, this.price});

  final String title;
  final String imgUrl;
  final String price;
}

class Choice {
  const Choice({this.title, this.icon, this.id});

  final String title;
  final IconData icon;
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
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
    Cate(title:'手机', imgUrl:'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg'),
  ];
}

class HomeTabData{
  List<Choice> getHomeTab() => <Choice>[
    Choice(title: '精选', icon: Icons.directions_car, id: 0),
    Choice(title: '数码', icon: Icons.directions_bike, id: 1),
    Choice(title: '女装', icon: Icons.directions_boat, id: 2),
    Choice(title: '鞋包', icon: Icons.directions_bus, id: 3),
    Choice(title: '户外', icon: Icons.directions_railway, id: 4),
    Choice(title: '美妆', icon: Icons.directions_walk, id: 5),
    Choice(title: '电器', icon: Icons.directions_walk, id: 6),
    Choice(title: '个护', icon: Icons.directions_walk, id: 7),
  ];
}

class HomeTestData {
//  HomeTestData({this.tag: ''});
//  final String tag;
  List<Goods> getTestGoods({tag: ""}){
    return [
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
      Goods(
          title:
          '${tag}一加OnePlus7Pro骁龙855旗舰性能4800万超广角三摄8GB+256GB皓月金全面屏游戏手机',
          imgUrl:
          'http://m.360buyimg.com/mobilecms/s750x750_jfs/t1/79706/18/6581/112584/5d492587E32ba70ae/47fdb0779e7dad8a.jpg',
          price: '¥4299.00'),
    ];
  }
}

