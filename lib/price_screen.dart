import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';




class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurr = 'AUD';


  List<DropdownMenuItem<String>> getDropDownItems(){
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList){

      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }
  List<Text> getPickerItems(){
    List<Text> pickerItems = [];
    for(int i = 0 ; i<currenciesList.length;i++){

      pickerItems.add(Text(currenciesList[i]));

    }
    return pickerItems;
  }
  String bitcoinValueInUSD = '?';

  void getData() async{
    try{
      double data = await CoinData().getCoinData(selectedCurr);

      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
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
                child: Text(
                  '1 BTC = $bitcoinValueInUSD $selectedCurr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlue,
              children:
                getPickerItems(),

              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex){
                setState(() {
                    selectedCurr = currenciesList[selectedIndex];

                    getData();

                });
              },
            )
          ),
        ],
      ),
    );
  }
}

