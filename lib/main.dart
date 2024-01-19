import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/features/auth/screen/home_feed/personal_feed.dart';
import 'package:gonomad/features/auth/screen/login_option_screen.dart';
//import 'package:gonomad/features/auth/screen/navigation_bar.dart';
//import 'features/auth/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(  const ProviderScope(child:  MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Show the status bar and hide the navigation bar
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BackgroundVideo(),
      //InstagramHome(),//MyHomePage(),
      
      
    );
  }
}
