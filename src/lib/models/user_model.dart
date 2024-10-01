
import 'dart:convert';

class UserModel {
	final String id;
	final String email;

	UserModel({required this.id, required this.email});

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return UserModel(
			id: json['id'] as String,
			email: json['email'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'email': email,
		};
	}

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;
		return other is UserModel && other.id == id && other.email == email;
	}

	@override
	int get hashCode => id.hashCode ^ email.hashCode;

	@override
	String toString() {
		return 'UserModel{id: $id, email: $email}';
	}
}
