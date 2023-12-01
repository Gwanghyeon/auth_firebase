import 'package:authentification_firebase/models/custom_error.dart';
import 'package:authentification_firebase/repository/auth_repository.dart';
import 'package:flutter/material.dart';

part 'signin_state.dart';

class SigninProvider with ChangeNotifier {
  SigninState _state = SigninState.initial();
  final AuthRepository authRepository;

  SigninProvider({required this.authRepository});

  SigninState get state => _state;

  Future<void> signIn({required String email, required String password}) async {
    // 상태를 로그인 중으로 변경
    _state = _state.copyWith(signinStatus: SigninStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signIn(email: email, password: password);
      // 성공한 경우
      _state = _state.copyWith(signinStatus: SigninStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state =
          _state.copyWith(signinStatus: SigninStatus.error, customError: e);
      notifyListeners();
      rethrow; // 해당 함수를 호출한 UI 파트에서 처리하도록 rethrow
    }
  }
}
