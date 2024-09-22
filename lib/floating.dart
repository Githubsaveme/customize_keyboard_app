import 'package:flutter/material.dart';

class ResizableDraggableKeyboard extends StatefulWidget {
  final ValueChanged<String> onKeyTap;

  const ResizableDraggableKeyboard({Key? key, required this.onKeyTap})
      : super(key: key);

  @override
  _ResizableDraggableKeyboardState createState() =>
      _ResizableDraggableKeyboardState();
}

class _ResizableDraggableKeyboardState
    extends State<ResizableDraggableKeyboard> {
  Offset position = Offset(50, 400); // Initial position of the keyboard
  double widthFactor = 1.0; // Initial width factor to match the screen width
  double heightFactor =
      0.4; // Initial height factor to set height (40% of screen height)

  // Adjust the size of the keyboard with constraints to prevent it from being too large or too small
  void _adjustSize({double widthAdjustment = 0, double heightAdjustment = 0}) {
    setState(() {
      // Adjust width and height factors with constraints
      widthFactor = (widthFactor + widthAdjustment).clamp(0.8, 1.5);
      heightFactor = (heightFactor + heightAdjustment).clamp(0.3, 0.6);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the dimensions of the keyboard based on screen size and adjustment factors
    double keyboardWidth = screenWidth * widthFactor;
    double keyboardHeight = screenHeight * heightFactor;

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta; // Update position while dragging
          });
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Controls for adjusting keyboard size
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.zoom_in),
                    onPressed: () => _adjustSize(
                        widthAdjustment: 0.1, heightAdjustment: 0.05),
                  ),
                  Text(
                    'Resizable Keyboard',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.zoom_out),
                    onPressed: () => _adjustSize(
                        widthAdjustment: -0.1, heightAdjustment: -0.05),
                  ),
                ],
              ),
              // Main keyboard area
              Container(
                height: keyboardHeight,
                width: keyboardWidth,
                child: _buildKeyboard(keyboardWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the keyboard layout dynamically
  Widget _buildKeyboard(double keyboardWidth) {
    // Calculate key size based on the keyboard width
    double keyWidth =
        (keyboardWidth - 80) / 10; // Estimate width with padding adjustments

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'], keyWidth),
        _buildRow(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], keyWidth),
        _buildRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M'], keyWidth),
        _buildRow(['Space', 'Enter', 'Backspace'], keyWidth),
      ],
    );
  }

  // Creates a row of keys, dynamically sized
  Widget _buildRow(List<String> keys, double keyWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        return GestureDetector(
          onTap: () => widget.onKeyTap(key),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Container(
              alignment: Alignment.center,
              width: key == 'Space' || key == 'Backspace'
                  ? keyWidth * 3
                  : keyWidth,
              // Adjust size for special keys
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                key,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
