import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoviesWidget extends StatefulWidget {
  @override
  _MoviesWidgetState createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: '\uE8b6 电影 / 电视剧 / 影人',
                hintStyle: TextStyle(fontFamily: 'MaterialIcons', fontSize: 16),
                contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 50),
                    child: TabBar(
                      unselectedLabelColor: Colors.black12,
                      labelColor: Colors.black87,
                      indicatorColor: Colors.black87,
                      tabs: <Widget>[
                        Tab(
                          text: '电影',
                        ),
                        Tab(
                          text: '电视',
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        children: <Widget>[
                          Center(
                            child: Text('电影'),
                          ),
                          Center(
                            child: Text('电视'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
