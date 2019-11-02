part of store;

class UserLoginRequest {}

class UserLoginSuccess {
  final User user;

  UserLoginSuccess(this.user);
}

class LoadUser {
  final User user;

  LoadUser(this.user);
}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

signIn(
  BuildContext context, {
  @required String username,
  @required String password,
}) {
  return (Store<AppState> store) async {
    store.dispatch(UserLoginRequest());
    try {
      final data = await AuthService.login(username, password);
      final user = User.fromJson(data['user']);
      store.dispatch(UserLoginSuccess(user));
      resetTo(context, HomeScreen());
    } catch (e) {
      if(e is DioError)
        showSnackbar(context, Text("Email or password is invalid."));

      store.dispatch(UserLoginFailure(e.message));
    }
  };
}
