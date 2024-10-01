
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc/bloc.dart';
import 'package:my_app/cubits/auth_cubit.dart';

// Mock dependencies if any
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		blocTest<AuthCubit, AuthState>(
			'initial state is AuthInitial',
			build: () => authCubit,
			verify: (cubit) => expect(cubit.state, AuthInitial()),
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), Authenticated(UserModel(id: '1', email: 'test@example.com'))],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [AuthLoading(), AuthError('Login failed')],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [Unauthenticated()],
		);
	});
}
