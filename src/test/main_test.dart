
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'lib/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('should have a MaterialApp widget', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('should have initial route as LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [Unauthenticated()],
		);
	});
}
