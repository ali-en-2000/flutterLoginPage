import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_page/dashboard.dart';
import 'package:login_page/error_page.dart';
import 'package:login_page/pages/otp.dart';
import 'package:login_page/pages/register.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

bool isLogin = false;
String phoneNumber = '';


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: storage.read(key: 'token'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            title: 'go router Demo',
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            isLogin = true;
          }
          return MaterialApp.router(
            title: 'go router Demo',
            routerConfig: _router,
          );
        }
      },
    );
  }



  final GoRouter _router = GoRouter(

      // initialLocation: "/profile",
      errorBuilder: (context, state) => const ErrorPage(),
      redirect: (context, state) {
        if (isLogin) {
          return "/";
        } else {
          return "/register";
        }
      },
      routes: <RouteBase>[
        GoRoute(
            path: "/",
            builder: ((context, state) => const Dashboard()),
            routes: [
              GoRoute(
                  path: "otp",
                  builder: ((context, state) => Otp(phoneNumber: phoneNumber))),
                  
              GoRoute(
                  path: "register",
                  builder: ((context, state) => const Register())),
            ]),
      ]);
}
