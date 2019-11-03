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
