import 'dart:async';

import 'package:tcryptoapp/data/coin_api.dart';
import 'package:tcryptoapp/models/coin.dart';

class CoinBloc {
  final coinStreamBuilder = StreamController.broadcast();

  Stream getStream() async*{
    await Future.delayed(Duration(seconds: 1));
    yield await getAll();
  }

  Future<List<Coin>> getAll() {
    return CoinApi.coinGetAll();
  }

}

final coinBloc = CoinBloc();
