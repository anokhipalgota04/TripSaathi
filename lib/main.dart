import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:gonomad/features/auth/screen/home_feed/home.dart';
import 'package:gonomad/features/auth/screen/home_feed/personal_feed.dart';

import 'package:gonomad/features/auth/screen/login_option_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:gonomad/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
FirebaseAppCheck.instance.activate();
  runApp(
    const riverpod.ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Show the status bar and hide the navigation bar
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const Personalfeed();
              }
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Something went wrong'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return const BackgroundVideo();
          },
        ),

        //BackgroundVideo(),
        //InstagramHome(),//MyHomePage(),
      ),
    );
  }
}
