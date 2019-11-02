part of store;

class ChangeIndex {
  final int index;
  ChangeIndex(this.index);
}

AppState appReducer(AppState state, action){

  if(action is ChangeIndex) {
    return state.copyWith(
      index: action.index
    );
  }

  return AppState(
    auth: authReducer(state.auth, action),
    articles: articlesReducer(state.articles, action),
  );
}
