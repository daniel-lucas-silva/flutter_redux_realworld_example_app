part of store;

class LoadUser {
  final User user;

  LoadUser(this.user);
}

class UserLogout {}

///

class UserLoginRequest {}

class UserLoginSuccess {}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

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
      store.dispatch(UserLoginSuccess());
      store.dispatch(LoadUser(user));
      resetTo(context, HomeScreen());
    } catch (e) {
      if (e is DioError)
        showSnackbar(context, Text("Email or password is invalid."));

      store.dispatch(UserLoginFailure(e.message));
    }
  };
}

// TODO:...
class UserUpdateRequest {}

class UserUpdateSuccess {}

class UserUpdateFailure {
  final String error;

  UserUpdateFailure(this.error);
}

updateUser(
  BuildContext context,
  Map<String, dynamic> data,
  Completer completer,
) {
  return (Store<AppState> store) async {
    store.dispatch(UserUpdateRequest());
    try {
      final res = await AuthService.update(data);
      final user = User.fromJson(res['user']);
      store.dispatch(UserUpdateSuccess());
      store.dispatch(LoadUser(user));
      completer.complete("User updated!");
    } catch (e) {
      if (e is DioError) store.dispatch(UserUpdateFailure(e.message));
      completer.completeError(Exception("Could not be updated."));
    }
  };
}

logout(BuildContext context) {
  return (Store<AppState> store) async {
    store.dispatch(UserLogout());
    store.dispatch(ClearArticles());
    store.dispatch(ChangeIndex(0));
    resetTo(context, HomeScreen());
  };
}
