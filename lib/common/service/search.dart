import 'package:dio/dio.dart';
import 'dart:convert';

getSearchResult(String keyworld, [int page = 0]) async {
  String url =
      'https://so.m.jd.com/ware/search._m2wq_list?keyword=$keyworld&datatype=1&callback=C&page=$page&pagesize=10&ext_attr=no&brand_col=no&price_col=no&color_col=no&size_col=no&ext_attr_sort=no&merge_sku=yes&multi_suppliers=yes&area_ids=1,72,2818&qp_disable=no&fdesc=%E5%8C%97%E4%BA%AC';
  var sr = [];
  try{
    Dio dio = new Dio();
    Response response = await dio.get(url);
    String resp = response.toString();
    var responseData = jsonDecode(resp.substring(2, resp.length - 2).replaceAll(RegExp(r'\\x..'), '/'));
    sr =  responseData['data']['searchm']['Paragraph'] as List;
  }catch(err){
    print(err);
  }
  return sr;
}