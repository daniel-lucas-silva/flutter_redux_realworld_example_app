part of store;

Reducer<CommentsState> commentsReducer = combineReducers([
  TypedReducer<CommentsState, ClearComments>(_clearComments),
  TypedReducer<CommentsState, LoadCommentsRequest>(_loadCommentRequest),
  TypedReducer<CommentsState, LoadCommentsSuccess>(_loadCommentsSuccess),
  TypedReducer<CommentsState, LoadCommentsError>(_loadCommentsError),
  TypedReducer<CommentsState, CreateCommentSuccess>(_createCommentSuccess),
]);

CommentsState _clearComments(CommentsState comments, ClearComments action) {
  return comments.copyWith(
    comments: null,
  );
}

CommentsState _loadCommentRequest(CommentsState comments, LoadCommentsRequest action) {
  return comments.copyWith(
    loading: true,
  );
}

CommentsState _loadCommentsSuccess(CommentsState comments, LoadCommentsSuccess action) {
  return comments.copyWith(
    loading: false,
    comments: action.comments,
  );
}


CommentsState _loadCommentsError(CommentsState comments, LoadCommentsError action) {
  return comments.copyWith(loading: false, error: action.error);
}

CommentsState _createCommentSuccess(CommentsState comments, CreateCommentSuccess action) {
  var items = comments.comments;
  items.insert(0, action.comment);
  return comments.copyWith(
    comments: items,
  );
}
