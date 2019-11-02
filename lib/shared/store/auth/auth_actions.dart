part of store;

class UserLoginRequest {}

class UserLoginSuccess {
  final user;

  UserLoginSuccess(this.user);
}

class LoadUser {
  final user;

  LoadUser(this.user);
}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

signInWithCredential(
  BuildContext context, {
  @required String username,
  @required String password,
}) {
  return (Store<AppState> store) async {
    store.dispatch(UserLoginRequest());
    store.dispatch(UserLoginSuccess(null));
    store.dispatch(UserLoginFailure(null));
  };
}
