import 'package:app/src/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'facebook_auth_service.dart';
import 'google_auth_service.dart';
import '../common/exceptions/authentication_exception.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await GoogleAuthService.instance.login();
                userProvider.setUser();
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
                userProvider.setUser();
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
