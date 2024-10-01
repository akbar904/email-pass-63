
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/home/home_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('renders HomeScreen with Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Home'), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('triggers logout when Logout button is pressed', (WidgetTester tester) async {
			when(() => authCubit.logout()).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Logout'));
			await tester.pump();

			verify(() => authCubit.logout()).called(1);
		});
	});
}
