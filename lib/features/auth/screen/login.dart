// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:gonomad/features/auth/screen/home_feed/navbar.dart';
import 'package:gonomad/resources/auth_methods.dart';
import 'package:gonomad/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginInUsers(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const PersonalFeed()));
    } else {
      // Show error message
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Spline1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white70.withOpacity(0.0),
                              Colors.white70.withOpacity(0.0),
                            ],
                          ),
                        ),
                      )))),
          // Welcome back text
          Positioned(
            top: screenSize.height * 0.105,
            left: screenSize.width * 0.06,
            child: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.155,
            left: screenSize.width * 0.06,
            child: Text(
              'Back!',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Glassmorphism Effect on Container with Blur
          Center(
            child: Container(
              width: screenSize.width * 0.95,
              height: screenSize.height * 0.53,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white70.withOpacity(0.4),
                    Colors.white70.withOpacity(0.3),
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
                          Colors.white70.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.027,
                        ),

                        //email textfield

                        SizedBox(
                          width: screenSize.width * 0.8,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    right: screenSize.width * 0.02),
                                child: const Icon(Icons.email_outlined),
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
                                vertical: screenSize.height * 0.02,
                                horizontal: screenSize.width * 0.04,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.022,
                        ),

                        //password textfield
                        SizedBox(
                          width: screenSize.width * 0.8,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    right: screenSize.width * 0.01),
                                child: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
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
                                vertical: screenSize.height * 0.02,
                                horizontal: screenSize.width * 0.04,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.022,
                        ),

                        //login button

                        GestureDetector(
                          child: InkWell(
                            onTap: loginUser,
                            child: Container(
                              width: screenSize.width * 0.8,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.015),
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
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.008,
                        ),

                        //forgot password

                        //terms and cond text
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),
                        const Text(
                          'By signing in you agree to',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
