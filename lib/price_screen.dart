import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  String selectedCrypto = "BTC";
  List<String> currentPrices=["?","?","?"];

  void setCurrencyData() async{
    List<String> currencyValue = await CoinData().getData(selectedCurrency);
    setState(() {
      currentPrices = currencyValue;
    });
  }

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];
    for(String item in currenciesList){
      pickerItems.add(Text(item));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        setCurrencyData();
        },
      children: pickerItems,
      backgroundColor: Colors.lightBlue,
    );
  }

  CupertinoPicker iOSCryptoPicker(){
    List<Text> pickerItems = [];
    for(String item in cryptoList){
      pickerItems.add(Text(item));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          selectedCrypto= currenciesList[selectedIndex];
        });
        setCurrencyData();
      },
      children: pickerItems,
      backgroundColor: Colors.lightBlue,
    );
  }

  DropdownButton<String> androidDropdownButton(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String i in currenciesList){
      dropdownItems.add(DropdownMenuItem(child: Text(i),value: i,));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
        });
        setCurrencyData();
      },

    );
  }

  DropdownButton<String> androidCryptoDropdownButton(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String i in cryptoList){
      dropdownItems.add(DropdownMenuItem(child: Text(i),value: i,));
    }
    return DropdownButton<String>(
      value: selectedCrypto,
      items: dropdownItems,
      onChanged: (value){
        setState(() {
          selectedCrypto = value;
        });
        setCurrencyData();
      },

    );
  }
  
  List<Text> getPrices(){
    List<Text> results=[];
    for(int i =0; i< cryptoList.length; i++){
      results.add(Text(
        '1 ${cryptoList[i]} = ${currentPrices[i]} $selectedCurrency',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),);
    }
    return results;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(children:
                    getPrices(),
                )
              ),
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker():androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}
