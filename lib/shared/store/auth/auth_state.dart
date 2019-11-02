part of store;

@immutable
class AuthState {
  final bool isAuthenticated;
  final bool loading;
  final User user;
  final String error;

  AuthState({
    this.isAuthenticated = false,
    this.loading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
    User user,
  }) {
    return new AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  factory AuthState.fromJSON(Map<String, dynamic> json) {
    return AuthState(
      isAuthenticated: json['isAuthenticated'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'isAuthenticated': this.isAuthenticated,
      'user': this.user,
    };
  }
}
