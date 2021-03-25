class Coin {
  String name;
  double low24hr;
  double high24hr;
  double last;
  double percentChange;

  Coin(this.name, this.low24hr, this.high24hr, this.last);

  Coin.fromObject(String name, dynamic o){
    this.name = name;
    this.low24hr = double.tryParse(o["low24hr"].toString());
    this.high24hr = double.tryParse(o["high24hr"].toString());
    this.last = double.tryParse(o["last"].toString());
    this.percentChange = double.tryParse(o["percentChange"].toString());
  }

}


