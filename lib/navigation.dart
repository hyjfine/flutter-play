
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('navigation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('hahahah'),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('home'),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.add_a_photo),
                title: new Text('phone'),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: new Text('mail'),
              ),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.map),
                  title: new Text('map'))
            ]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}

//void main() => runApp(new Navigation());