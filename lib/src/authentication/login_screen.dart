import 'package:app/src/authentication/facebook_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'google_auth_service.dart';
import '../common/exceptions/authentication_exception.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TOFO: Create dedicated widget for button
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await GoogleAuthService.instance.login();
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
            icon: const FaIcon(
              FontAwesomeIcons.google,
            ),
            label: const Text('Google login'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await FacebookAuthService.instance.login();
              } on AuthenticationException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Facebook Authentication failed (${e.toString()})'),
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Something went wrong while trying to login with Facebook.'),
                ));
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.facebook,
            ),
            label: const Text('Facebook login'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              GoogleAuthService.instance.logout();
            },
            icon: const Icon(Icons.abc),
            label: const Text('logout'),
          ),
        ],
      ),
    );
  }
}
