
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multithreaded_trading_app/components/item.dart';
import 'package:multithreaded_trading_app/components/item2.dart';
import 'package:multithreaded_trading_app/model/coinModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override 
  void initState() {
    getCoinMarkett(); 
    // getCoinMarkett();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.yellow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: w*0.02,vertical: h*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        'Main portfolio',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ),
                  Text(
                      'Top 10 coins',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      'Experimental',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '\$5,450',
                        style: TextStyle(
                          fontSize: 30,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      SizedBox(height: 15,),
                       Text(
                    '+ 162% all time',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  )
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.stacked_line_chart,color: Colors.black,),
                  )
                ],
              ),
            ),
            
            Container(
              height: h*0.75,
              width: w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                            decoration: TextDecoration.none
                          ),
                        ),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                  // SizedBox(height: h*0.02,),
                  isRefreshing == true? 
                    Center(
                      child: CircularProgressIndicator(),
                    ):
                    ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Item(
                        item: coinMarket![index],
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w*0.05),
                      child: Row(
                        children: [
                          Text(
                            'Recomended to Buy',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold  
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: h*0.01,),
                     Expanded(
                       child: Padding(
                         padding:  EdgeInsets.only(left:   w*0.03),
                         child: isRefreshing==true?Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                         ):  coinMarket == null || coinMarket!.length == 0
                              ? Padding(
                                  padding: EdgeInsets.all(h * 0.06),
                                  child: Center(
                                    child: Text(
                                      'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ):Container(
                          // height: h*0.22,
                          width: w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder:(context,index){
                              return Item2(
                                item: coinMarket![index],
                              );    
                            } ),
                        ),
                       ),
                     ),
                     SizedBox(height: h*0.015,)
      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRefreshing = true;


  List? coinMarket= [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarkett() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?x-cg-demo-api-key:CG-A63u7JXgegypxub6xnov5By1&vs_currency=usd&sparkline=true';
    setState(() {
      isRefreshing= true;
    });
    var response = await http.get(Uri.parse(url),headers: {
      "Content-Type": "application/json",
      "Accept":"application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if(response.statusCode == 200){
      var x = response.body;    
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else{
      print(response.statusCode);
    }
  }
}