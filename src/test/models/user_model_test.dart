
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_app/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should correctly serialize from JSON', () {
      final json = {'id': '123', 'email': 'user@example.com'};
      final user = UserModel.fromJson(json);
      expect(user.id, '123');
      expect(user.email, 'user@example.com');
    });

    test('should correctly deserialize to JSON', () {
      final user = UserModel(id: '123', email: 'user@example.com');
      final json = user.toJson();
      expect(json, {'id': '123', 'email': 'user@example.com'});
    });

    test('should have correct equality and hashCode', () {
      final user1 = UserModel(id: '123', email: 'user@example.com');
      final user2 = UserModel(id: '123', email: 'user@example.com');
      final user3 = UserModel(id: '124', email: 'other@example.com');

      expect(user1, user2);
      expect(user1.hashCode, user2.hashCode);
      expect(user1, isNot(user3));
      expect(user1.hashCode, isNot(user3.hashCode));
    });

    test('should have correct toString implementation', () {
      final user = UserModel(id: '123', email: 'user@example.com');
      expect(
        user.toString(),
        'UserModel{id: 123, email: user@example.com}',
      );
    });
  });
}
