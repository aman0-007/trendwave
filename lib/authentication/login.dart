import 'package:flutter/material.dart';
import 'package:trendwave/authentication/forgotpassword.dart';
import 'package:trendwave/authentication/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
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
              SizedBox(height: screenHeight * 0.155), // Adds 10% height as empty space
              Center(
                child: Image.asset(
                  'assets/app/TrendWave.png',
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.35,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Added space below the logo

              // Welcome Text
              Text(
                "WELCOME BACK!",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenWidth * 0.07,
                ),
              ),

              // Blurred Gratitude Text
              Opacity(
                opacity: 0.7,
                child: Text(
                  "We're glad to see you again at TrendWave!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Added space after the intro line

              // Email/Mobile Field with Blurred Label and Hint
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email or Mobile Number',
                  hintText: 'Enter your email or mobile',
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
              SizedBox(height: screenHeight * 0.02),

              // Password Field with Toggle for Show/Hide Password
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),

              // Blurred Forgot Password Link, Closer to Password Field
              Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: 0.7,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.00000001), // Moved closer
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),

              // Login Button with Click Effect
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isButtonPressed = true),
                  onTapUp: (_) => setState(() => _isButtonPressed = false),
                  onTapCancel: () => setState(() => _isButtonPressed = false),
                  onTap: () {
                    // Login action
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
                      "Login",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // "Don't Have an Account?" with "Register Now" Below
              Center(
                child: Column(
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Register Now >>>",
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
