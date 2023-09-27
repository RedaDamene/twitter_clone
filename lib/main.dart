import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ConnexionPage(),
      ),
      GoRoute(
        path: '/home/:email',
        builder: (context, state) => TwitterPage(
            state.pathParameters['email'] ?? ""
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state){
          if(state.extra != null && state.extra is String){
            return TwitterPage(state.extra as String);
          } else {
            return const TwitterPage("");
          }
        },
      )
    ],

  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}