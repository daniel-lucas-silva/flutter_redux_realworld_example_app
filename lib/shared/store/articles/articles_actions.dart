part of store;

class ClearArticles {}

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

loadArticles(
  BuildContext context, {
  bool isFeed: false,
  Completer completer,
}) {
  return (Store<AppState> store) async {
    store.dispatch(LoadArticlesRequest());
    try {
      if (isFeed) {
        final json = await ArticlesService.feed();
        List<Article> articles = (json['articles'] as List)
            .map<Article>((a) => Article.fromJson(a))
            .toList();
        store.dispatch(LoadFeedArticlesSuccess(articles));
      } else {
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
class CreateArticleRequest {}
class CreateArticleSuccess {
  final Article article;

  CreateArticleSuccess(this.article);
}
class CreateArticleError {
  final String error;
  CreateArticleError(this.error);
}

createArticle(
  BuildContext context,
  Completer completer, {
  @required String title,
  @required String description,
  @required String body,
  List<String> tagList,
}) {
  return (Store<AppState> store) async {
    store.dispatch(CreateArticleRequest());
    try {
      final res = await ArticlesService.create(title, description, body, tagList);
      final article = Article.fromJson(res['article']);
      store.dispatch(CreateArticleSuccess(article));
      completer.complete("Article created!");
    } catch (e) {
      if (e is DioError) store.dispatch(CreateArticleError(e.message));
      completer.completeError(Exception("Could not be created."));
    }
  };
}
