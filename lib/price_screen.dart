import 'package:bitcoin_ticker/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  Map<String, String> cryptoCurrencies = {};
  bool isWaiting = true;

  DropdownButton getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String item in currenciesList) {
      dropdownItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Widget> dropdownItems = [];

    for (String item in currenciesList) {
      dropdownItems.add(Text(item));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        getData();
      },
      children: dropdownItems,
    );
  }

  void getData() async {
    try {
      Map<String, String> coinsData = await CoinData().getCoinData(_selectedCurrency);
      isWaiting = false;

      setState(() {
        cryptoCurrencies = coinsData;
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                cryptoLabel: 'BTC',
                bitcoinValue: isWaiting ? '?' : cryptoCurrencies['BTC']!,
                selectedCurrency: _selectedCurrency,
              ),
              CryptoCard(
                cryptoLabel: 'ETH',
                bitcoinValue: isWaiting ? '?' : cryptoCurrencies['ETH']!,
                selectedCurrency: _selectedCurrency,
              ),
              CryptoCard(
                cryptoLabel: 'LTC',
                bitcoinValue: isWaiting ? '?' : cryptoCurrencies['LTC']!,
                selectedCurrency: _selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getAndroidDropdown() : getIOSPicker(),
          ),
        ],
      ),
    );
  }
}
