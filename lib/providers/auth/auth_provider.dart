import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../repository/auth_repository.dart';

part 'auth_state.dart';

// User 상태가 변화할 때 마다 listener에게 알려주는 역할
class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.initalize();

  AuthProvider({required this.authRepository});
  AuthState get state => _state;

  final AuthRepository authRepository;

  void update(fbAuth.User? user) {
    // 로그인의 경우
    if (user != null) {
      _state =
          _state.copyWith(authStatus: AuthStatus.authenticated, user: user);
      // 로그아웃의 경우
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    print('authState: $_state');
    notifyListeners();
  }

  void signOut() async {
    await authRepository.signOut();
  }
}
