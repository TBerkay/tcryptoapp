import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tcryptoapp/bloc/coin_bloc.dart';

class CoinListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoinListState();
  }
}

class CoinListState extends State<CoinListScreen> {
  @override
  void initState() {
    setUpTimedFetch();
    super.initState();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(seconds:30), (timer) {
      setState(() {
        coinBloc.getStream();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Crypto App"),
        ),
      ),
      body: _buildCoinList(),
    );
  }

  Widget _buildCoinList() {
    return StreamBuilder(
      stream: coinBloc.getStream(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return _buildCoinListItem(snapshot);
            break;
          default:
            return Center(child: Text("Hata"));
        }
      },
    );
  }

  Widget _buildCoinListItem(AsyncSnapshot snapshot) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(snapshot.data.length, (index) {
        return _buildCoinField(snapshot.data[index]);
      }),
    );
  }

  Widget _buildCoinField(data) {
    var color;

    if (data.percentChange >= 10) {
      color = Color.fromRGBO(0, 153, 51, 0.5);
    } else if (data.percentChange > 0 && data.percentChange < 10) {
      color = Colors.green;
    } else if (data.percentChange == 0) {
      color = Color.fromRGBO(204, 255, 204, 0.5);
    } else if (data.percentChange < 0 && data.percentChange > -10) {
      color = Colors.red;
    } else {
      color = Color.fromRGBO(204, 0, 0, 0.5);
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 5.0),
        margin: EdgeInsets.all(1.0),
        color: color,
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNameText(data.name),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLastText(data.last),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPercentChangeText(data.percentChange),
                ],
              )),
        ]));
  }

  Widget _buildNameText(String name) {
    var item = name.split("_");
    return Text(
      item[0],
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLastText(last) {
    return Text(
      last.toString() + " TL",
      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPercentChangeText(percentChange) {
    return Text(
      "%" + percentChange.toString(),
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

/*return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, index) {
        final list = snapshot.data;
        return ListTile(
          title: _buildNameText(list[index].name.toString()),
          subtitle: Text(list[index].last.toString()),
        );
      },
    );*/
