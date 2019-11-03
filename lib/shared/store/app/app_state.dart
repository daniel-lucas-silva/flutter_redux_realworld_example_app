part of store;

@immutable
class AppState {
  final int index;
  final AuthState auth;
  final ArticlesState articles;
  final CommentsState comments;

  AppState({
    this.index = 0,
    AuthState auth,
    ArticlesState articles,
    CommentsState comments,
  })  : auth = auth ?? AuthState(),
        articles = articles ?? ArticlesState(),
        comments = comments ?? CommentsState();

  static AppState rehydrationJSON(dynamic json) {
    return json != null
        ? AppState(
            auth: AuthState.fromJSON(json['auth']),
            articles: ArticlesState.fromJSON(json['articles']),
          )
        : AppState();
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth.toJSON(),
      'articles': articles.toJSON(),
    };
  }

  AppState copyWith({
    bool rehydrated,
    int index,
    AuthState auth,
    ArticlesState articles,
    CommentsState comments,
  }) {
    return AppState(
      index: index ?? 0,
      auth: auth ?? this.auth,
      articles: articles ?? this.articles,
      comments: comments ?? this.comments,
    );
  }
}
