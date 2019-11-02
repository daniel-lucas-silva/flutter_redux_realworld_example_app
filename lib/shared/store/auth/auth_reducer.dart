part of store;

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, UserLoginRequest>(_userLoginRequest),
  TypedReducer<AuthState, UserLoginSuccess>(_userLoginSuccess),
  TypedReducer<AuthState, UserLoginFailure>(_userLoginFailure),
  TypedReducer<AuthState, UserLogout>(_userLogout),
  TypedReducer<AuthState, LoadUser>(_loadUser),
]);

AuthState _userLoginRequest(AuthState auth, UserLoginRequest action) {
  return auth.copyWith(
    isAuthenticated: false,
    isAuthenticating: true,
  );
}

AuthState _userLoginSuccess(AuthState auth, UserLoginSuccess action) {
  return auth.copyWith(
    isAuthenticated: true,
    isAuthenticating: false,
  );
}

AuthState _userLoginFailure(AuthState auth, UserLoginFailure action) {
  return auth.copyWith(
    isAuthenticated: false,
    isAuthenticating: false,
    error: action.error,
  );
}

AuthState _userLogout(AuthState auth, UserLogout action) {
  return AuthState();
}

AuthState _loadUser(AuthState auth, LoadUser action) {
  return auth.copyWith(user: action.user);
}
