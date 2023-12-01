import 'package:authentification_firebase/pages/home_page.dart';
import 'package:authentification_firebase/pages/signin_page.dart';
import 'package:authentification_firebase/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 분기의 시작점 역할: Login or Home page
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  // Name of route
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthProvider>().state;

    if (authState.authStatus == AuthStatus.authenticated) {
      // 현재 진행되는 빌드 작업 완료 후 호출되도록 스케쥴링
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    } else if (authState.authStatus == AuthStatus.unauthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SigninPage.routeName);
      });
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
