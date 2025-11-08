enum AppRole {
  superAdmin(level: 100, label: 'Super Admin'),
  admin(level: 90, label: 'Admin'),
  manager(level: 80, label: 'Manager'),
  user(level: 50, label: 'User'),
  guest(level: 10, label: 'Guest');

  const AppRole({required this.level, required this.label});
  final int level;
  final String label;

  bool get isSuperAdmin => this == AppRole.superAdmin;
  bool get isAdmin => this == AppRole.admin || isSuperAdmin;
  bool get isManager => this == AppRole.manager || isAdmin;
  bool get isUser => this == AppRole.user || isManager;

  static AppRole fromString(String role) {
    return AppRole.values.firstWhere(
      (r) => r.toString().split('.').last == role,
      orElse: () => AppRole.guest,
    );
  }
}