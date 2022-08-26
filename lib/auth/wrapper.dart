import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_kidz/auth/auth_service.dart';
import 'package:tracker_kidz/auth/user_model.dart';
import 'package:tracker_kidz/home_screen/homescreen.dart';
import 'package:tracker_kidz/onboarding/onboarding_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_,AsyncSnapshot<User?>snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          final User?user=snapshot.data;
          return user == null ? OnboardingScreen() : HomeScreen();
        } else {
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
}
