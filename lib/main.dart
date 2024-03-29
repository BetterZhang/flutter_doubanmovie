import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './citys/CitysWidget.dart';
import './hot/HotWidget.dart';
import './mine/MineWidget.dart';
import './movies/MoviesWidget.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '豆瓣电影'),
      routes: {
        '/Citys': (context) => CitysWidget(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  final _widgetItems = [HotWidget(), MoviesWidget(), MineWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetItems[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('热映'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.panorama_fish_eye),
            title: Text('找片'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('我的'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 刷新界面
    });
  }
}
