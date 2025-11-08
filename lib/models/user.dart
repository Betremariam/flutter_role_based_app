import 'role.dart';

class User {
  final String id;
  final String email;
  final String name;
  final List<AppRole> roles;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.roles,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => AppRole.fromString(e.toString()))
              .toList() ??
          [AppRole.guest],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'roles': roles.map((role) => role.toString().split('.').last).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool hasRole(AppRole role) => roles.contains(role);

  bool hasAnyRole(List<AppRole> requiredRoles) {
    return roles.any((role) => requiredRoles.contains(role));
  }

  bool hasAllRoles(List<AppRole> requiredRoles) {
    return requiredRoles.every((role) => roles.contains(role));
  }

  String get highestRole {
    if (roles.isEmpty) return AppRole.guest.label;
    final highest = roles.reduce((a, b) => a.level > b.level ? a : b);
    return highest.label;
  }
}
