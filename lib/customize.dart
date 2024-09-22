import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      if (value == 'Clear') {
        _input = '';
      } else if (value == 'Enter') {
        _toggleKeyboard();
        // Handle the "Enter" key press
      } else {
        _input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard Demo'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Input: $_input',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleKeyboard,
                  child: const Text('Toggle Keyboard'),
                ),
              ],
            ),
          ),
          if (_isKeyboardVisible)
            FloatingKeyboard(
              onKeyTap: _onKeyTap,
            ),
        ],
      ),
    );
  }
}

class FloatingKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyTap;

  const FloatingKeyboard({Key? key, required this.onKeyTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            String label;
            if (index < 9) {
              label = '${index + 1}';
            } else if (index == 9) {
              label = 'Clear';
            } else if (index == 10) {
              label = '0';
            } else {
              label = 'Enter';
            }

            return GestureDetector(
              onTap: () => onKeyTap(label),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
