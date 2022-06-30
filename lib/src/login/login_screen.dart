import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../authentication/google_auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ElevatedButton.icon(
          onPressed: () async {
            await GoogleAuthService.instance.googleLogin();
            print('oook');
          },
          icon: const Icon(Icons.stop_circle_sharp),
          label: const Text('Google login'),
        ),
      ),
    );
  }
}
