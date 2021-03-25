import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tcryptoapp/models/coin.dart';
import 'package:http/http.dart' as http;

class CoinApi {

  static Future<List<Coin>> coinGetAll() async{

    var apiUrl = await http.get("https://www.paribu.com/ticker");

    var jsonData = json.decode(apiUrl.body);

    List coinNames =[];
    List<Coin> coinDetail = [];
    List<Coin> coins = [];

    for(var item in jsonData.keys){
      coinNames.add(item);
    }

    for(int i=0; i<jsonData.length; i++){

      coinDetail.add(Coin.fromObject(coinNames[i],jsonData[coinNames[i]]));
    }

    for(int i = 0; i<coinDetail.length; i++){
      var item = coinDetail[i].name.split("_");

      if(item[1] == "TL")
        {
          coins.add(coinDetail[i]);
        }
    }
    return coins;
  }
}