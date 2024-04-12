import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:firebase_core/firebase_core.dart';
import 'package:gonomad/features/auth/screen/login_option_screen.dart';
import 'package:gonomad/features/auth/screen/onboarding_screen.dart'; // Import your OnboardingScreen
import 'package:gonomad/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'features/auth/screen/home_feed/navbar.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const riverpod.ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const PersonalFeed();
              } else {
                // Check if onboarding is completed
                bool isOnboardingCompleted = false; // Change this based on your app's logic
                if (isOnboardingCompleted) {
                  // If user is not logged in and onboarding is completed,
                  // show the BackgroundVideo screen
                  return const BackgroundVideo();
                } else {
                  // If user is not logged in and onboarding is not completed,
                  // show the onboarding screen
                  return OnboardingScreen();

                }
              }
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Something went wrong'),
                ),
              );
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
