
import 'dart:convert';

import 'package:multithreaded_trading_app/model/coinModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchData {
    bool isRefreshing = true;


  List<CoinModel>? coinMarket= [];
  var coinMarketList;
   
  Future<CoinModel?> getCoinMarkett() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?x-cg-demo-api-key:CG-A63u7JXgegypxub6xnov5By1&vs_currency=usd&sparkline=true';
   
    final response = await http.get(Uri.parse(url),headers: {
      "Content-Type": "application/json",
      "Accept":"application/json",
    });
        
    if(response.statusCode == 200){
      var x = response.body;    
      coinMarketList = coinModelFromJson(x);
    //  return (response.statusCode);
    // return CoinModel.fromJson(jsonDecode(response.body));
    return coinMarketList[0];
      // return coinMarketList;
     
    
    } else{
      print(response.statusCode);
    }
  }
  Future<int?> getResponse() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?x-cg-demo-api-key:CG-A63u7JXgegypxub6xnov5By1&vs_currency=usd&sparkline=true';
   
    final response = await http.get(Uri.parse(url),headers: {
      "Content-Type": "application/json",
      "Accept":"application/json",
    });
        if(response.statusCode==200){
          return response.statusCode;
        }
  }
}
