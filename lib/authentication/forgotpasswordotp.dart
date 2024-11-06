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

  @override
  void dispose() {
    // Clean up the focus nodes when the widget is disposed
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
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
              // Title Text
              SizedBox(height: screenHeight * 0.155), // Adds space from the top
              Text(
                "Enter OTP",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: screenHeight * 0.007), // Space below the title

              // Instructional Text
              Text(
                "Enter the OTP received in your registered email/number",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: screenWidth * 0.037,
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Space before the OTP fields

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
              SizedBox(height: screenHeight * 0.05), // Space after OTP fields

              // Validate Password Button
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: () {
                    // Handle OTP validation
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
