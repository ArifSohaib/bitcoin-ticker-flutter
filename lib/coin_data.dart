import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AFN',
  'AUD',
  'BRL',
  'BTC',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PKR',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<List<String>> getData(String currency) async{

    List<String> rate = [];
    for(String crypto in cryptoList) {
      http.Response response = await http.get(
          "https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$currency");
      if (response.statusCode == 200) {
        rate.add(jsonDecode(response.body)["last"].toString());
      }
      else{
        rate.add("-1");
      }
    }
    return rate;
  }
}
