import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_role.dart';

class UserRoleNotifier extends Notifier<UserRole> {
  @override
  UserRole build() {
    // Default to actor for now, or change to agent to test the new screens
    return UserRole.agent; 
  }

  void setRole(UserRole role) {
    state = role;
  }
}

final userRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(() {
  return UserRoleNotifier();
});
