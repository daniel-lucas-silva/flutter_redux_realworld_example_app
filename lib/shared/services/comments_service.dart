part of services;

class CommentsService {
  static create(String slug, Map<String, dynamic> comment) async => await api.post('/articles/$slug/comments', data: comment);

  static delete(String slug, commentId) async => await api.delete('/articles/$slug/comments/$commentId');

  static forArticle(String slug) async => await api.get('/articles/$slug/comments');
}
