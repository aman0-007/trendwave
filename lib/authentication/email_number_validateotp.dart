import 'dart:async';
import 'package:flutter/material.dart';

class ValidateUserOtpScreen extends StatefulWidget {
  const ValidateUserOtpScreen({Key? key}) : super(key: key);

  @override
  State<ValidateUserOtpScreen> createState() => _ValidateUserOtpScreenState();
}

class _ValidateUserOtpScreenState extends State<ValidateUserOtpScreen> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isButtonPressed = false;
  bool _isResendEnabled = true; // Controls whether the Resend OTP is enabled
  late String _countdownTime;
  late Timer _timer;
  int _remainingTime = 120; // Start time in seconds (2 minutes)

  @override
  void initState() {
    super.initState();
    _countdownTime = _formatTime(_remainingTime);
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  // Start the countdown when the user clicks "Resend OTP"
  void _startCountdown() {
    if (_timer.isActive) {
      return; // Prevent starting the timer if it's already active
    }

    setState(() {
      _isResendEnabled = false; // Disable the Resend OTP text
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _countdownTime = _formatTime(_remainingTime);
        } else {
          _isResendEnabled = true; // Re-enable Resend OTP when countdown finishes
          _timer.cancel();
          _remainingTime = 120; // Reset countdown for next use
          _countdownTime = _formatTime(_remainingTime);
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
              // Logo at the top
              SizedBox(height: screenHeight * 0.07),
              Center(
                child: Image.asset(
                  'assets/app/TrendWave.png', // Replace with your logo asset
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Title Text: "Validate Email/Number"
              Text(
                "Validate Email/Number",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: screenHeight * 0.0009),

              // Instructional Text: "Enter the OTP received to validate your email/number"
              Text(
                "Enter the OTP received to validate your email/number",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: screenWidth * 0.036,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOtpField(controller: _otpController1, focusNode: _focusNode1, nextFocusNode: _focusNode2),
                  _buildOtpField(controller: _otpController2, focusNode: _focusNode2, nextFocusNode: _focusNode3),
                  _buildOtpField(controller: _otpController3, focusNode: _focusNode3, nextFocusNode: _focusNode4),
                  _buildOtpField(controller: _otpController4, focusNode: _focusNode4, nextFocusNode: null),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),

              // Validate Button
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: () {
                    // Handle OTP validation logic here
                    print("OTP entered: ${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}");
                  },
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

              SizedBox(height: screenHeight * 0.05),

              // Countdown and "Resend OTP" text below the button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _isResendEnabled ? _startCountdown : null,
                    child: Text(
                      "Didn't receive? Resend",
                      style: TextStyle(
                        color: _isResendEnabled
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _countdownTime,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
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

  Widget _buildOtpField({required TextEditingController controller, required FocusNode focusNode, FocusNode? nextFocusNode}) {
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
        textAlign: TextAlign.center,  // Ensures text is centered inside the field
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
          if (nextFocusNode == null && value.isNotEmpty) {
            FocusScope.of(context).unfocus();  // Unfocus to close keyboard when last field is filled
          }
        },
      ),
    );
  }
}
