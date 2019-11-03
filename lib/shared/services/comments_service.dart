part of services;

class CommentsService {
  static create(String slug, String comment) async {
    return await api.post(
      '/articles/$slug/comments',
      data: {
        "comment": {
          "body": comment,
        },
      },
    );
  }

  static delete(String slug, commentId) async =>
      await api.delete('/articles/$slug/comments/$commentId');

  static forArticle(String slug) async =>
      await api.get('/articles/$slug/comments');
}
