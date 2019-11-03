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
    store.dispatch(LoadArticlesRequest());
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
