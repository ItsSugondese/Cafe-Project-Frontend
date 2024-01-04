enum Roles { admin, staff }

extension RolesExtension on Roles {
  String get stringValue {
    return this.toString().split('.').last;
  }
}
