import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isButtonPressed = false;
  bool _isResendEnabled = false;
  late String _countdownTime;
  Timer? _timer;
  int _remainingTime = 120; // 2 minutes countdown

  @override
  void initState() {
    super.initState();
    _countdownTime = _formatTime(_remainingTime);
    _startCountdown();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();

    setState(() {
      _isResendEnabled = false;
      _remainingTime = 120;
      _countdownTime = _formatTime(_remainingTime);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _countdownTime = _formatTime(_remainingTime);
        } else {
          _isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _validateOtp() {
    final enteredOtp = "${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}";

    if (enteredOtp == "1234") {
      print("OTP Validated Successfully!");
      // Navigate to the next screen or perform further actions
    } else {
      print("Invalid OTP");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  void _resendOtp() {
    if (_isResendEnabled) {
      _startCountdown();
      _otpController1.clear();
      _otpController2.clear();
      _otpController3.clear();
      _otpController4.clear();
      print("OTP resent");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.07),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.155),
              Text(
                "Enter OTP",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: screenHeight * 0.007),
              Text(
                "Enter the OTP received in your registered email/number",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: screenWidth * 0.037,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOtpField(controller: _otpController1, focusNode: _focusNode1, nextFocusNode: _focusNode2),
                  _buildOtpField(controller: _otpController2, focusNode: _focusNode2, nextFocusNode: _focusNode3, prevFocusNode: _focusNode1),
                  _buildOtpField(controller: _otpController3, focusNode: _focusNode3, nextFocusNode: _focusNode4, prevFocusNode: _focusNode2),
                  _buildOtpField(controller: _otpController4, focusNode: _focusNode4, prevFocusNode: _focusNode3),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: _validateOtp,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: _isButtonPressed
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: _isButtonPressed
                          ? []
                          : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    alignment: Alignment.center,
                    child: Text(
                      "Validate OTP",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _resendOtp,
                    child: Text(
                      "Didn't receive? Resend",
                      style: TextStyle(
                        color: _isResendEnabled ? Theme.of(context).colorScheme.primary : Colors.grey,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!_isResendEnabled)
                    Text(
                      _countdownTime,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    FocusNode? prevFocusNode,
  }) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: "",
        ),
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        onTap: () {
          // Ensure cursor is at the end of the text field
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (nextFocusNode != null) {
              // Move focus to the next field if available
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              // No next field, so unfocus and close the keyboard
              FocusScope.of(context).unfocus();
            }
          } else if (value.isEmpty && prevFocusNode != null) {
            // Move focus to the previous field if backspacing
            FocusScope.of(context).requestFocus(prevFocusNode);
          }
        },
        onFieldSubmitted: (_) {
          // Unfocus if the field is empty when submitted and it’s the last field
          if (controller.text.isEmpty && prevFocusNode != null) {
            FocusScope.of(context).requestFocus(prevFocusNode);
          }
        },
      ),
    );
  }
}
