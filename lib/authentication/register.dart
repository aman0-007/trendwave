import 'package:flutter/material.dart';
import 'package:trendwave/authentication/email_number_validateotp.dart';
import 'package:trendwave/authentication/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents screen from sliding up
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.1), // Adds space for logo

              // Logo
              Center(
                child: Image.asset(
                  'assets/app/TrendWave.png',
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.35,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Added space below the logo

              // Register Text
              Text(
                "REGISTER",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenWidth * 0.07,
                ),
              ),
              SizedBox(height: screenHeight * 0.001), // Space between title and intro text

              // Short Intro Text
              Opacity(
                opacity: 0.7,
                child: Text(
                  "Join TrendWave and enjoy the best shopping experience.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Space after the intro text

              // Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Space after name field

              // Surname Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Space after surname field

              // Email/Mobile Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email or Mobile Number',
                  hintText: 'Enter your email or mobile number',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.033), // Space after email/mobile field

              // Register Button with Click Effect
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const ValidateUserOtpScreen()),
                    );
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
                      "Get OTP",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Space below the register button

              // Already have an account? Login Now
              Center(
                child: Column(
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login Now >>>",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
