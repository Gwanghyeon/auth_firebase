// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_provider.dart';

enum SigninStatus {
  initial,
  submitting, // 로그인중
  success,
  error,
}

// 로그인 과정의 상태를 관리하기 위한 클래스
class SigninState {
  final SigninStatus signinStatus;
  final CustomError customError;

  SigninState({required this.signinStatus, required this.customError});

  factory SigninState.initial() => SigninState(
      signinStatus: SigninStatus.initial, customError: CustomError());

  SigninState copyWith({
    SigninStatus? signinStatus,
    CustomError? customError,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      customError: customError ?? this.customError,
    );
  }
}
