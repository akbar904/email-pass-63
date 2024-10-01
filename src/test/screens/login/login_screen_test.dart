
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/screens/login/login_screen.dart';

// Mock dependencies if necessary
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password text fields and a login button', (WidgetTester tester) async {
			// Build the LoginScreen widget
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);

			// Verify if email field is present
			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.byKey(Key('email_field')), findsOneWidget);
			expect(find.byKey(Key('password_field')), findsOneWidget);

			// Verify if login button is present
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should display loading indicator when state is AuthLoading', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthLoading()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);

			// Verify if CircularProgressIndicator is shown
			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		blocTest<AuthCubit, AuthState>(
			'emit [AuthLoading, Authenticated] when login is successful',
			build: () => AuthCubit(),
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emit [AuthLoading, AuthError] when login fails',
			build: () => AuthCubit(),
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [AuthLoading(), AuthError('Invalid credentials')],
		);
	});
}
