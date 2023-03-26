import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
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

const String apiLink = 'https://rest.coinapi.io/v1/exchangerate';
const String apikey = 'apikey=525151C8-E7B6-42B0-AAF3-118A7A492563';

class CoinData {
  Future<double> getCoinData(String selectedCurrency) async {
    http.Response response = await http.get(Uri.parse("$apiLink/BTC/$selectedCurrency?$apikey"));

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['rate'];
    } else {
      throw 'The response failed';
    }
  }
}
