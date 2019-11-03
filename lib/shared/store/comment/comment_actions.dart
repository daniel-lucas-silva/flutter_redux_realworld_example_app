part of store;

class ClearComments {}

class LoadCommentsRequest {}

class LoadCommentsSuccess {
  final List<Comment> comments;

  LoadCommentsSuccess(this.comments);
}

class LoadCommentsError {
  final String error;

  LoadCommentsError(this.error);
}
class CreateCommentRequest {}
class CreateCommentSuccess {
  final Comment comment;

  CreateCommentSuccess(this.comment);
}

loadComments(
  BuildContext context,
  String slug, {
  Completer completer,
}) {
  return (Store<AppState> store) async {
    store.dispatch(LoadCommentsRequest());
    try {
      final json = await CommentsService.forArticle(slug);
      List<Comment> comments = (json['comments'] as List)
          .map<Comment>((a) => Comment.fromJson(a))
          .toList();

      store.dispatch(LoadCommentsSuccess(comments));

      if (completer != null) completer.complete();
    } catch (e) {
      print(e.message);
    }
  };
}

createComment(BuildContext context, String slug, String body, { Completer completer }) {
  return (Store<AppState> store) async {

    store.dispatch(CreateCommentRequest());
    try {
      final json = await CommentsService.create(slug, body);
      final comment = Comment.fromJson(json['comment']);
      
      store.dispatch(CreateCommentSuccess(comment));
      
      if(completer != null) completer.complete(comment);

    } catch (e) {
      if(completer != null) completer.completeError(e);
      print(e.message);
    }
  };
}
