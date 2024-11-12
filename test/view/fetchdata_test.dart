import 'package:flutter_test/flutter_test.dart';
import 'package:multithreaded_trading_app/data/fetchdata.dart';
import 'package:multithreaded_trading_app/model/coinModel.dart';
import 'package:multithreaded_trading_app/view/home.dart';

void main() {
  late FetchData datafetch;

  setUp((){
   datafetch = FetchData();
  });
  group('checking if our model is storing api data correctly ot not ',(){
    test('testing for the api', () async{
      final getData= await datafetch.getCoinMarkett();

      expect(getData,isA<CoinModel>());
    });
    test('Checking if the api is working or not', () async{
      final getData= await datafetch.getResponse();

      expect(getData,200);
    });
  
  });
}