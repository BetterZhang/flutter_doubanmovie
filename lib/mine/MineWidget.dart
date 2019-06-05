import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MineWidget extends StatefulWidget {
  @override
  _MineWidgetState createState() => _MineWidgetState();
}

class _MineWidgetState extends State<MineWidget> {

  static const platformChannel = const MethodChannel('samples.flutter.io/toast');
  static const channel = const MethodChannel('samples.flutter.io/message');
  static const eventChannel = const EventChannel('samples.flutter.io/event');

  String textContent = 'Flutter Message';
  String textContent2 = 'Flutter Message too';

  @override
  void initState() {
    super.initState();
    channel.setMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case 'showText':
          String content = await methodCall.arguments['content'];
          if (content != null && content.isNotEmpty) {
            setState(() {
              textContent = content;
            });
            return 'success';
          } else {
            throw PlatformException(
              code: '-1',
              message: 'showText fail',
              details: 'content is null'
            );
          }
          break;
        default:
          throw MissingPluginException();
          break;
      }
    });
    eventChannel.receiveBroadcastStream().listen(_onListen, onError: _onError, onDone: _onDone, cancelOnError: false);
  }

  void _onListen(dynamic data) {
    setState(() {
      textContent2 = data;
    });
  }

  void _onError(Object o) {
    setState(() {
      textContent2 = 'EventChannel error';
    });
  }

  void _onDone() {
    setState(() {
      textContent2 = 'EventChannel done';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Platform Channel'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            child: Text('Show Toast'),
            onPressed: () {
              showToast('Flutter Toast');
            },
          ),
          Text(textContent),
          Text(textContent2),
        ],
      ),
    );
  }

  void showToast(String content) async {
    var arguments = Map();
    arguments['content'] = content;

    try {
      String result = await platformChannel.invokeMethod('toast', arguments);
      print('showToast ' + result);
    } on PlatformException catch (e) {
      print('showToast ' + e.code + e.message + e.details);
    } on MissingPluginException catch (e) {
      print('showToast ' + e.message);
    }
  }
}