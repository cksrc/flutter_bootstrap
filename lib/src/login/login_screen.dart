import 'package:flutter/material.dart';

import '../authentication/google_auth_service.dart';
import '../common/exceptions/authentication_exception.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              try {
                await GoogleAuthService.instance.googleLogin();
              } on AuthenticationException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Google Authentication failed (${e.toString()})'),
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Something went wrong while trying to login with Google.'),
                ));
              }
            },
            icon: const Icon(Icons.stop_circle_sharp),
            label: const Text('Google login'),
          ),
        ),
      ),
    );
  }
}
