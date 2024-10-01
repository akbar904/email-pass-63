import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

// AuthState definition
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthAuthenticated extends AuthState {}

// AuthCubit definition
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      // Simulate network call
      await Future.delayed(Duration(seconds: 1));
      if (email == 'test@example.com' && password == 'password') {
        emit(Authenticated(UserModel(id: '1', email: email)));
      } else {
        emit(AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError('An unknown error occurred'));
    }
  }

  void logout() {
    emit(Unauthenticated());
  }

  void emailChanged(String email) {
    // Implementation for changing the email
  }

  void passwordChanged(String password) {
    // Implementation for changing the password
  }
}
