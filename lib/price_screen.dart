import 'dart:io';
import 'package:bitcoin_ticker/card.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var secondCurrency='USD';
  var currentCurrency = 'USD';
  Map<dynamic,dynamic> cryptoPrices={};
  void data()async{
    var data= await CoinData().getData(secondCurrency);
    setState(() {
      cryptoPrices=data;
    });
  }
  Widget getIos() {
    List<Widget> items = [];
    for (String item in currenciesList) {
      var newItem = Text(item);
      items.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        setState(() {
          secondCurrency=currenciesList[value];
        });

      },
      children: items,
      backgroundColor: Colors.lightBlue,
    );
  }
  Widget getAndroid() {
    List<DropdownMenuItem> dropdownMenu = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenu.add(newItem);
    }
    return DropdownButton(
      value: currentCurrency,
      onChanged: (value) {
        setState(() {
          currentCurrency = value;
          secondCurrency=value;
        });

      },
      items: dropdownMenu,
    );
  }
@override
  void initState() {
    super.initState();
    data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CardWidget(
                cryptoPrices['BTC'],
                secondCurrency,
                'BTC'),
            CardWidget(
                cryptoPrices['ETH'],
                secondCurrency,
                'ETH'),
            CardWidget(
                cryptoPrices['LTC'],
                secondCurrency,
                'LTC'),
            Padding(
              padding: EdgeInsets.only(top: 350.0),
              child: Container(
                height: 90.0,
                alignment: Alignment.center,
                color: Colors.lightBlue,
                child: Platform.isIOS ? getIos() : getAndroid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
