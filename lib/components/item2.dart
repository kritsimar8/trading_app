
import 'package:flutter/material.dart';
import 'package:multithreaded_trading_app/selectCoin.dart';

class Item2 extends StatelessWidget {
  var item;
   Item2({this.item});

  @override
  Widget build(BuildContext context) {
       double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: w*0.03,vertical: h*0.009),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>SelectCoin(selectItem: item,)));
        },
        child: Container(
          width: w*0.33,
          padding: EdgeInsets.only(
            left: w*0.03,
            right: w*0.03,
            top: h*0.02,
            bottom: h*0.02
            )  ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              height: h*0.05,
              child: Image.network(item.image)),
               SizedBox(height: h*0.025,),
              Text(
                item.id,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
               SizedBox(height: h*0.01,),
              Row(children: [
                Text(
                  '\$' + item.priceChange24H.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                  ),
                ),
                SizedBox(width: w*0.03,),
                Text(
                  item.marketCapChangePercentage24H.toStringAsFixed(2)+'%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color:  item.marketCapChangePercentage24H >=0
                                ? Colors.green
                                : Colors.red
                  ),
                )
              ],)
          ],),
        ),
      ),
    );
  }
}