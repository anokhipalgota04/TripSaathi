// google_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/features/auth/controller/auth_controller.dart';
import 'package:gonomad/features/auth/screen/login_option_screen.dart';

class GoogleButton extends ConsumerWidget {
  final VoidCallback onPressed;

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle();
  }

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildFrostedButton(
      context,
      'CONTINUE WITH GOOGLE',
      customImagePath: 'assets/images/google.png',
      onPressed: () =>signInWithGoogle(ref),
    );
  }
}
