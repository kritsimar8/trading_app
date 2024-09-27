
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart    ';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
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
  void initState(){
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
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
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 500,),
        Center(
         child: ElevatedButton(onPressed:(){
          makePayment();
         }, child: Text('Buy Now')), 
        )       
      ],),
    );
  }
}