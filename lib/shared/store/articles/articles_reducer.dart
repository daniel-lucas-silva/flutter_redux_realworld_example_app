part of store;

Reducer<ArticlesState> articlesReducer = combineReducers([
  TypedReducer<ArticlesState, ClearArticles>(_clearArticles),
  TypedReducer<ArticlesState, LoadArticlesRequest>(_loadRequest),
  TypedReducer<ArticlesState, LoadGlobalArticlesSuccess>(_loadGlobalSuccess),
  TypedReducer<ArticlesState, LoadFeedArticlesSuccess>(_loadFeedSuccess),
  TypedReducer<ArticlesState, LoadArticlesError>(_loadError),
  TypedReducer<ArticlesState, CreateArticleSuccess>(_createArticleSuccess),
]);

ArticlesState _clearArticles(ArticlesState articles, ClearArticles action) {
  return articles.copyWith(
//    global: null,
    feed: null,
  );
}

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

ArticlesState _createArticleSuccess(ArticlesState articles, CreateArticleSuccess action) {
  var items = articles.global;
  items.insert(0, action.article);
  return articles.copyWith(
    global: items,
  );
}
