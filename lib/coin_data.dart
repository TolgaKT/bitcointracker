import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';

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


class CoinData {

  Future getCoinData(String selectedCurrency) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=8FAF1D07-88E7-4A35-AA3C-B21AD6E74795');
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      var lastPrice = decodedData['rate'];

      return (lastPrice);
    }
    else {
      throw(response.statusCode);
    }
  }
}


