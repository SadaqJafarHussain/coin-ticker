import 'dart:convert';
import 'package:http/http.dart';

 const apiKey='7B617463-7A33-48BD-8442-F6DE3C596457';
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

  Future getData(String secondCurrency) async{
    Map<String,String> cryptoPrices={};
    for(String crypto in cryptoList){
      var data= await networkData('https://rest.coinapi.io/v1/'
          'exchangerate/$crypto/$secondCurrency?apikey=$apiKey');
      cryptoPrices[crypto]=data['rate'].toStringAsFixed(0);
    }
    return cryptoPrices;
  }
  Future networkData(String url)async{
    Response response= await get(url);
    var data= response.body;
    return jsonDecode(data);
  }
}
