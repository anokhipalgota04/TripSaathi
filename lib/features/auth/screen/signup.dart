import 'dart:ui';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _emailError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      final String email = _emailController.text.trim();
      _emailError = !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(email);
    });
  }

  void signUpUser() async {
    _validateEmail();

    if (!_emailError) {
      setState(() {
        _isLoading = true;
      });

      // Add your signup logic here

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildPunchlineText(screenSize),
          _buildGlassmorphismContainer(screenSize),
          _buildAgreementText(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Spline1.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white70.withOpacity(0.0),
                  Colors.white70.withOpacity(0.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPunchlineText(Size screenSize) {
    return Positioned(
      top: screenSize.height * 0.065,
      left: screenSize.width * 0.06,
      child: Text(
        'Get Started!',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenSize.width * 0.1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGlassmorphismContainer(Size screenSize) {
    return Center(
      child: Container(
        width: screenSize.width * 0.95,
        height: screenSize.height * 0.72,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white70.withOpacity(0.4),
              Colors.white70.withOpacity(0.3)
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white70.withOpacity(0.3),
                    Colors.white70.withOpacity(0.3)
                  ],
                ),
              ),
              child: _buildFormFields(screenSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: () {
                  // Add your logic for image upload
                },
                icon: Icon(Icons.add_a_photo),
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * 0.032),
        _buildTextField(
          hintText: 'Enter Username',
          suffixIcon: const Icon(Icons.person),
          onChanged: (value) {
            // Add your logic here
          },
          keyboardType: TextInputType.text,
          controller: _usernameController,
        ),
        SizedBox(height: screenSize.height * 0.022),
        _buildTextField(
          hintText: 'Enter Email',
          errorText: _emailError ? 'Enter a valid email' : null,
          suffixIcon: const Icon(Icons.email_outlined),
          onChanged: (_) => _validateEmail(),
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        SizedBox(height: screenSize.height * 0.022),
        _buildTextField(
          hintText: 'Enter Password',
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          onChanged: (_) {},
          keyboardType: TextInputType.text,
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
        ),
        SizedBox(height: screenSize.height * 0.022),
        _buildTextField(
          hintText: 'Enter Bio',
          suffixIcon: const Icon(Icons.info),
          onChanged: (value) {
            // Add your logic here
          },
          keyboardType: TextInputType.text,
          controller: _bioController,
        ),
        SizedBox(height: screenSize.height * 0.022),
        _buildSignupButton(screenSize),
        SizedBox(height: screenSize.height * 0.008),
      ],
    );
  }

  Widget _buildTextField({
    required String hintText,
    String? errorText,
    required Widget suffixIcon,
    required void Function(String) onChanged,
    required TextInputType keyboardType,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          suffixIcon: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.00),
            child: suffixIcon,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white70.withOpacity(0.3),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildSignupButton(Size screenSize) {
    return InkWell(
      onTap: signUpUser,
      child: Container(
        width: screenSize.width * 0.8,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Colors.purpleAccent, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: !_isLoading
            ? const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }

  Widget _buildAgreementText() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'By signing up you agree to',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              // Add logic for terms and conditions
            },
            child: const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
