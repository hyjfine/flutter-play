import 'package:flutter/material.dart';
import 'package:flutter_app/animationList.dart';
import 'package:flutter_app/appBarBottomWidget.dart';
import 'package:flutter_app/basicAppBar.dart';
import 'package:flutter_app/expansionTiles.dart';
import 'package:flutter_app/friendlyChat.dart';
import 'package:flutter_app/helloword.dart';
import 'package:flutter_app/myAppA.dart';
import 'package:flutter_app/navigation.dart';
import 'package:flutter_app/testChannel.dart';

class ItemModel {
  const ItemModel({this.title, this.route});

  final String title;
  final Route route;
}

class RootList extends StatelessWidget {
  final List<ItemModel> _items = [];

  _getItems() {
    _items.clear();
    _items.add(new ItemModel(
        title: 'animationList',
        route: MaterialPageRoute(
            builder: (BuildContext context) => AnimationList())));
    _items.add(new ItemModel(
        title: 'appBarBottomWidget',
        route: MaterialPageRoute(
            builder: (BuildContext context) => AppBarBottom())));
    _items.add(new ItemModel(
        title: 'basicAppBar',
        route: MaterialPageRoute(
            builder: (BuildContext context) => BasicAppBar())));
    _items.add(new ItemModel(
        title: 'expansionTiles',
        route: MaterialPageRoute(
            builder: (BuildContext context) => ExpansionTiles())));
    _items.add(new ItemModel(
        title: 'friendlyChat',
        route: MaterialPageRoute(
            builder: (BuildContext context) => FriendlyChat())));
    _items.add(new ItemModel(
        title: 'main',
        route: MaterialPageRoute(builder: (BuildContext context) => MyApp())));
    _items.add(new ItemModel(
        title: 'myApp',
        route: MaterialPageRoute(builder: (BuildContext context) => MyAppA())));
    _items.add(new ItemModel(
        title: 'bottomNavigationBar',
        route: MaterialPageRoute(
            builder: (BuildContext context) => Navigation())));
    _items.add(new ItemModel(
        title: 'testChannel',
        route: MaterialPageRoute(
            builder: (BuildContext context) => TestChannel())));
  }

  String _getItemTitle(int index) {
    return _items[index].title;
  }

  Route _getItemRoute(int index) {
    return _items[index].route;
  }

  void _onTap(BuildContext context, int index) {
    Navigator.push(context, _getItemRoute(index));
  }

  @override
  Widget build(BuildContext context) {
    _getItems();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RootList'),
        ),
        body: ListView.separated(
            padding: new EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int index) {
              print(_getItemTitle(index));
              return RawMaterialButton(
                child: Text('${_getItemTitle(index)}'),
                onPressed: () => _onTap(context, index),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(16.0),
                constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                new Divider(),
            itemCount: _items.length),
      ),
    );
  }
}

void main() => runApp(new RootList());
