import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies = [];
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();

    getCurrencies();
  }

  void getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit50";

    http.Response response = await http.get(cryptoUrl);
    currencies = json.decode(response.body);

    this.setState(() {
      this.currencies = currencies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto Mobile"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0   
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
        child: new Flex(
      direction: Axis.vertical,
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = currencies[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUi(currency, color);
            },
          ),
        ),
      ],
    ));
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return new ListTile(
        leading: new CircleAvatar(
            backgroundColor: color, child: new Text(currency['name'][0])),
        title: new Text(currency['name'],
            style: new TextStyle(fontWeight: FontWeight.bold, color: color)),
        isThreeLine: true,
        subtitle: _getSubtitleText(
            currency['price_usd'], currency['percent_change_1h']),
            );
  }

  Widget _getSubtitleText(String price, String percentChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$price\n", style: new TextStyle(color: Colors.black));

    String percentageChangeText = "1 hr: $percentChange%";
    TextSpan percentageChangeWidget;

    if (double.parse(percentChange) > 0) {
      percentageChangeWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }

    return new RichText(
      text: new TextSpan(children: [priceTextWidget, percentageChangeWidget]),
    );
  }
}
