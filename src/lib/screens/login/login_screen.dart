import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    key: Key('email_field'),
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (value) {
                      context.read<AuthCubit>().emailChanged(value);
                    },
                  ),
                  TextField(
                    key: Key('password_field'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) {
                      context.read<AuthCubit>().passwordChanged(value);
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Assuming email and password are obtained from the TextField controllers.
                      final email =
                          'example@example.com'; // Replace with actual email
                      final password =
                          'password'; // Replace with actual password
                      context.read<AuthCubit>().login(email, password);
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
