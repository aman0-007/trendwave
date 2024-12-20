import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trendwave/components/dealpage.dart';
import 'package:trendwave/components/featuredproducts.dart';
import 'package:trendwave/components/supersave.dart';
import 'package:trendwave/components/topproducts.dart';
import 'package:trendwave/components/imagecarousel.dart';
import 'package:trendwave/components/top picks.dart';
import 'package:trendwave/components/offcategories.dart';

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
  bool _showClearIcon = false;
  bool _isManualEntry = false;
  Timer? _restartAnimationTimer;
  List<String> _hintTexts = [
    'Search the TrendWave.',
    'Join the wave of trend...',
    'Find the latest fashion trends.',
    'Explore your style with TrendWave.',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty && _isManualEntry;
      });
    });

    Future.delayed(const Duration(seconds: 2), _startTypingAnimation);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.microtask(() => _controller.clear()); // Ensure full clear on focus
        _stopTypingAnimation();
        _isManualEntry = true;
      } else if (_controller.text.isEmpty) {
        _isManualEntry = false;
        _restartAnimationTimer = Timer(const Duration(seconds: 2), () {
          _currentTextIndex = 0;
          _startTypingAnimation();
        });
      }
    });
  }

  void _startTypingAnimation() {
    if (_controller.text.isNotEmpty || _isManualEntry) return;
    if (_currentTextIndex >= _hintTexts.length) _currentTextIndex = 0;

    _typeText(_hintTexts[_currentTextIndex]);
  }

  void _typeText(String text) async {
    _displayText = '';
    _controller.text = '';

    for (int i = 0; i < text.length; i++) {
      if (_focusNode.hasFocus || _isManualEntry) return;
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _displayText += text[i];
        _controller.text = _displayText;
      });
    }

    await Future.delayed(const Duration(milliseconds: 1000));
    _backspaceText();
  }

  void _backspaceText() async {
    while (_displayText.isNotEmpty) {
      if (_focusNode.hasFocus || _isManualEntry) return;
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _displayText = _displayText.substring(0, _displayText.length - 1);
        _controller.text = _displayText;
      });
    }
    _currentTextIndex = (_currentTextIndex + 1) % _hintTexts.length;
    _startTypingAnimation();
  }

  void _stopTypingAnimation() {
    setState(() {
      _displayText = '';
    });
    _restartAnimationTimer?.cancel();
  }

  void _clearTextField() {
    _controller.clear();
    setState(() {
      _showClearIcon = false;
      _isManualEntry = false;
    });

    _restartAnimationTimer?.cancel();
    _restartAnimationTimer = Timer(const Duration(seconds: 2), _startTypingAnimation); // Delay restart animation
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displayHeight * 0.009),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: displayWidth * 0.01),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/app/TrendWaveLogo.png',
                      width: displayWidth * 0.1,
                      height: displayHeight * 0.05,
                    ),
                    SizedBox(width: displayWidth * 0.03),
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
                            const Icon(Icons.search, color: Colors.grey),
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: _displayText,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: _isManualEntry ? Colors.black : Colors.grey),
                              ),
                            ),
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
              ImageCarousel(),
              ProductCardRow(),
              TopProductsPage(),
              DealsForYou(),
              TopPicksForYou(),
              SupersavePage(),
              OffCategoriesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
