part of 'auth_provider.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

// States that are controlled: AuthStatus, fbAuth.User
class AuthState {
  final AuthStatus authStatus;
  final fbAuth.User? user;

  AuthState({required this.authStatus, this.user});

  factory AuthState.initalize() => AuthState(authStatus: AuthStatus.unknown);

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
