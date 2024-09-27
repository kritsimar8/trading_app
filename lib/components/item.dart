import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: w*0.04, vertical: h*0.02),
      child: Container(
        child: Row( 
          children:[
            Expanded(
              flex: 1,
              child: Container(
                height: h*0.06,
                child: Image.network(item.image)),
            ),
              SizedBox(width: w*.03,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.id,
                      style: TextStyle(
                        fontSize: 17  ,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '0.4 '+ item.symbol,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: w*0.02,),   
              Expanded(
                flex: 2,
                child: Container(
                  height: h*0.05,
                  width: w*0.1,
                  child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 2.0,
                    lineColor: item.marketCapChangePercentage24H >=0 ?Colors.green: Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                      begin: Alignment.topCenter, 
                      end: Alignment.bottomCenter,
                      stops: const [0.0,0.7],
                      colors: item.marketCapChangePercentage24H >=0
                      ?[Colors.green , Colors.green.shade100]:[Colors.red , Colors.red.shade100]
                    ),
                    ),
                ),
              ),
                        SizedBox(width: w*0.08,),   
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$' + item.currentPrice.toString(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ), 
                    ),
                    Row(
                      children: [
                        Text(
                          item.priceChange24H.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey
                          ),
                        ),
                        SizedBox(width: w*0.03,),
                        Text(item.marketCapChangePercentage24H.toStringAsFixed(3),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: item.marketCapChangePercentage24H >=0
                              ? Colors.green
                              : Colors.red
                        ),
                        )
                      ],
                    )
                  ],
                ),
              )
              ],
        ),
      ),
    );
  }
}
