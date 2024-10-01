import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'cubits/auth_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple App',
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: LoginScreen(),
            ),
        '/home': (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: HomeScreen(),
            ),
      },
    );
  }
}
