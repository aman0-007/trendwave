import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  int _currentTextIndex = 0;
  String _displayText = '';
  Timer? _animationTimer;
  Timer? _restartAnimationTimer;
  bool _showClearIcon = false;
  List<String> _hintTexts = [
    'Search the TrendWave',
    'Join the wave of trend',
    'Find the latest fashion trends',
    'Explore your style with TrendWave',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Add listener to show or hide the clear icon based on user input
    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty; // Show clear icon when there's text
      });
    });

    // Start typing animation after a delay when the page opens
    Future.delayed(const Duration(seconds: 2), _startTypingAnimation);

    // Listen for focus changes to handle stopping and starting the animation
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _stopTypingAnimation();
      } else if (_controller.text.isEmpty) {
        // Only restart animation if search bar is empty
        _restartAnimationTimer = Timer(const Duration(seconds: 2), () {
          _currentTextIndex = 0;
          _startTypingAnimation();
        });
      }
    });
  }

  // Start typing animation sequence
  void _startTypingAnimation() {
    if (_controller.text.isNotEmpty) return; // Skip if there's manual text input
    if (_currentTextIndex < _hintTexts.length) {
      _typeText(_hintTexts[_currentTextIndex]);
    } else {
      _currentTextIndex = 0;
      _typeText(_hintTexts[_currentTextIndex]);
    }
  }

  // Type the text one character at a time
  void _typeText(String text) {
    _displayText = ''; // Clear current display text
    for (int i = 0; i < text.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (_focusNode.hasFocus || _controller.text.isNotEmpty) return; // Stop if user interacts
        setState(() {
          _displayText = text.substring(0, i + 1); // Update display text character by character
          _controller.text = _displayText;
        });
      });
    }

    // Start backspace after the text has been fully typed out
    Future.delayed(Duration(milliseconds: 100 * text.length + 1000), () {
      _backspaceText();
    });
  }

  // Simulate deleting the typed text
  void _backspaceText() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_focusNode.hasFocus || _controller.text.isNotEmpty) return; // Stop if user interacts
      if (_displayText.isNotEmpty) {
        setState(() {
          _displayText = _displayText.substring(0, _displayText.length - 1);
          _controller.text = _displayText;
        });
        _backspaceText(); // Continue backspacing
      } else {
        // Move to the next hint text
        _currentTextIndex++;
        _startTypingAnimation(); // Start typing the next hint text
      }
    });
  }

  // Stop typing animation and clear display text
  void _stopTypingAnimation() {
    setState(() {
      _displayText = '';
    });
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _restartAnimationTimer?.cancel(); // Cancel any scheduled restart
  }

  // Clear the text field when the clear icon is tapped
  void _clearTextField() {
    _controller.clear();
    setState(() {
      _showClearIcon = false; // Hide the clear icon after clearing text
    });
    _restartAnimationTimer?.cancel(); // Cancel animation restart if it's scheduled
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationTimer?.cancel();
    _restartAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: displayHeight * 0.009), // Space between logo and search bar
            // Logo and Search Bar Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displayWidth * 0.01),
              child: Row(
                children: [
                  // App Logo on the left
                  Image.asset(
                    'assets/app/TrendWaveLogo.png', // Replace with your logo path
                    width: displayWidth * 0.1,
                    height: displayHeight * 0.05,
                  ),
                  SizedBox(width: displayWidth * 0.03), // Space between logo and search bar
                  // Search bar
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey), // Search icon
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: _displayText, // Animated hint text
                                hintStyle: const TextStyle(color: Colors.grey), // Grey hint text
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black), // Black text color for manual typing
                            ),
                          ),
                          // Clear icon only visible when there's manual input text
                          if (_showClearIcon)
                            GestureDetector(
                              onTap: _clearTextField,
                              child: const Icon(Icons.clear, color: Colors.grey),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Other content below (optional)
            Center(child: Text('Home Page', style: theme.textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
