part of services;

class ArticlesService {
  static all({int page, int lim: 50}) async => await api.get('/articles?${_limit(lim, page)}');

  static byAuthor(String author, {int page}) async => await api.get('/articles?author=$author&${_limit(5, page)}');

  static byTag(String tag, {int page, int lim: 50}) async => await api.get('/articles?tag=$tag&${_limit(lim, page)}');

  static del(String slug) async => await api.delete('/articles/$slug');

  static favorite(String slug) async => await api.post('/articles/$slug/favorite');

  static favoritedBy(String author, {int page}) async => await api.get('/articles?favorited=$author&${_limit(5, page)}');

  static feed() async => await api.get('/articles/feed?limit=50&offset=0');

  static get(slug) async => await api.get('/articles/$slug');

  static unfavorite(String slug) async => await api.delete('/articles/$slug/favorite');

  static update(String slug, Map<String, dynamic> data) async => await api.put('/articles/$slug', data: data);

  static create(Map<String, dynamic> data) async => await api.post('/articles', data: data);

  static String _limit(count, p) => 'limit=$count&offset=${p != null ? p * count : 0}';
}
