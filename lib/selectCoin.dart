import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart    ';
import 'package:flutter/material.dart';
import 'package:multithreaded_trading_app/model/chartModel.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;
  SelectCoin({this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;
    Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "SUCCESS PAYENT: ${response.paymentId}",timeInSecForIosWeb: 4); 
  }
  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "ERROR PAYMENT: ${response.code} - ${response.message}",timeInSecForIosWeb: 4); 
  }
  void _handlePaymentWallet(ExternalWalletResponse response){
     Fluttertoast.showToast(msg: " EXTERNAL_WALLET    : ${response.walletName}",timeInSecForIosWeb: 4); 
  }


  @override
  void initState() {
     _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
    getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }
  void makePayment() async{
    var options = {
      'key':'rzp_test_qklyMXPpN5S4EO',
      'amount':2000,
      'name':'krit',
      'description':'iphone 15',
      'prefill':{'contact': '+9599388031','email':'kritsimarsingh@gmail.com'},
    };
    try{
      _razorpay?.open(options);
    }catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05, vertical: h * 0.05),
            
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: h * 0.08,
                            child: Image.network(widget.selectItem.image)),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id,
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Text(
                              widget.selectItem.symbol,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$' + widget.selectItem.currentPrice.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H
                                  .toString() +
                              '%',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              
            ),
            Divider(),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: h * 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'LOW',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            '\$' + widget.selectItem.low24H.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'HIGH',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            '\$' + widget.selectItem.high24H.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'VOL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            '\$' +
                                widget.selectItem.totalVolume
                                    .toStringAsFixed(0),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //  SizedBox(height: h*0.01,),
                Container(
                  height: h * 0.35,
                  width: w,
                  child: isRefresh == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xffFBC700),
                          ),
                        )
                      : SfCartesianChart(
                          // primaryXAxis: NumericAxis(
                          //   minimum: 1727006400000,
                          //   maximum:  1727091000000,
                          // ),
                          // primaryYAxis: NumericAxis(
                          //   minimum: 62500,
                          //   interval: 100,
                          //   maximum: 64500,
                          // ),
                          trackballBehavior: trackballBehavior,
                          zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true, zoomMode: ZoomMode.x),
                          series: <CandleSeries>[
                            CandleSeries<ChartModel, int>(
                              enableSolidCandles: true,
                              enableTooltip: true,
                              dataSource: itemChart,
                              bullColor: Color.fromARGB(255, 44, 243, 74),
                              bearColor: Colors.red,
                              xValueMapper: (ChartModel sales, _) => sales.time,
                              lowValueMapper: (ChartModel sales, _) =>
                                  sales.low,
                              highValueMapper: (ChartModel sales, _) =>
                                  sales.high,
                              openValueMapper: (ChartModel sales, _) =>
                                  sales.open,
                              closeValueMapper: (ChartModel sales, _) =>
                                  sales.close,
                              animationDuration: 55,
                            )
                          ],
                        ),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                  height: h * 0.035,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: text.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                textbool = [
                                  false,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ];
                                textbool[index] = true;
                              });
                              setDays(text[index]);
                              getChart();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.03, vertical: h * 0.005),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: textbool[index] == true
                                    ? Color(0xffFBC700).withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                              child: Text(
                                text[index],
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )),
            Container(
              height: h * 0.1,
              width: w,
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:() {
                          makePayment();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.06,
                            vertical: h * 0.016,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFBC700),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                'Add to portfolio',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
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

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textbool = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;
  bool isRefresh = true;
  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id +
        '/ohlc?x-cg-demo-api-key:CG-A63u7JXgegypxub6xnov5By1&vs_currency=usd&days=' +
        days.toString();
    ;
    setState(() {
      isRefresh = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      print(response.body);
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
