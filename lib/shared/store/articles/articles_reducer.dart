part of store;

Reducer<ArticlesState> articlesReducer = combineReducers([
  TypedReducer<ArticlesState, LoadArticlesRequest>(_loadRequest),
  TypedReducer<ArticlesState, LoadGlobalArticlesSuccess>(_loadGlobalSuccess),
  TypedReducer<ArticlesState, LoadFeedArticlesSuccess>(_loadFeedSuccess),
  TypedReducer<ArticlesState, LoadArticlesError>(_loadError),
  TypedReducer<ArticlesState, SetCurrentArticle>(_setCurrent),
]);

ArticlesState _loadRequest(ArticlesState articles, LoadArticlesRequest action) {
  return articles.copyWith(
    loading: true,
  );
}

ArticlesState _loadGlobalSuccess(ArticlesState articles, LoadGlobalArticlesSuccess action) {
  return articles.copyWith(
    loading: false,
    global: action.articles,
  );
}

ArticlesState _loadFeedSuccess(ArticlesState articles, LoadFeedArticlesSuccess action) {
  return articles.copyWith(
    loading: false,
    feed: action.articles,
  );
}

ArticlesState _loadError(ArticlesState articles, LoadArticlesError action) {
  return articles.copyWith(loading: false, error: action.error);
}

ArticlesState _setCurrent(ArticlesState articles, SetCurrentArticle action) {
  return articles.copyWith(current: action.article.title);
}
