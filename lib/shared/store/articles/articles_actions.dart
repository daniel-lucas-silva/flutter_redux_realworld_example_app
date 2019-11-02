part of store;

class LoadArticlesRequest {}

class LoadGlobalArticlesSuccess {
  final List<Article> articles;

  LoadGlobalArticlesSuccess(this.articles);
}

class LoadFeedArticlesSuccess {
  final List<Article> articles;

  LoadFeedArticlesSuccess(this.articles);
}

class LoadArticlesError {
  final String error;

  LoadArticlesError(this.error);
}

class SetCurrentArticle {
  final Article article;

  SetCurrentArticle(this.article);
}

loadArticles(
  BuildContext context, {
  bool isFeed: false,
  Completer completer,
}) {
  return (Store<AppState> store) async {
    store.dispatch(LoadArticlesRequest());
    try {

      if(isFeed) {
        final json = await ArticlesService.feed();
        List<Article> articles = (json['articles'] as List)
            .map<Article>((a) => Article.fromJson(a))
            .toList();
        store.dispatch(LoadFeedArticlesSuccess(articles));
      }
      else {
        final json = await ArticlesService.all();
        List<Article> articles = (json['articles'] as List)
            .map<Article>((a) => Article.fromJson(a))
            .toList();
        store.dispatch(LoadGlobalArticlesSuccess(articles));
      }

      if (completer != null) completer.complete();
    } catch (e) {
      print(e.message);
    }
  };
}

Function refreshArticles(
  BuildContext context, {
  @required Completer completer,
}) {
  return (Store<AppState> store) {
    store.dispatch(new LoadArticlesRequest());
  };
}

final Function(BuildContext, Article) setCurrentArticle = (context, article) {
  return (Store<AppState> store) {
    store.dispatch(SetCurrentArticle(article));
  };
};
