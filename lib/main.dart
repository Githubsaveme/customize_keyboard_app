import 'package:flutter/material.dart';

import 'floating.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isKeyboardVisible = false;
  String _input = '';

  void _toggleKeyboard() {
    setState(() {
      _isKeyboardVisible = !_isKeyboardVisible;
    });
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'Backspace' && _input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      } else if (value == 'Enter') {
        _toggleKeyboard(); // Handle enter key action
      } else if (value != 'Space') {
        _input += value;
      } else {
        _input += ' ';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resizable Keyboard'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Input: $_input',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleKeyboard,
                  child: Text('Toggle Keyboard'),
                ),
              ],
            ),
          ),
          if (_isKeyboardVisible)
            ResizableDraggableKeyboard(
              onKeyTap: _onKeyTap,
            ),
        ],
      ),
    );
  }
}
