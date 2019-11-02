part of services;

class CommentsService {
  create(String slug, Map<String, dynamic> comment) async => await api.post('/articles/$slug/comments', data: comment);

  delete(String slug, commentId) async => await api.delete('/articles/$slug/comments/$commentId');

  forArticle(String slug) async => await api.get('/articles/$slug/comments');
}
