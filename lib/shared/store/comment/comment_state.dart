part of store;

@immutable
class CommentsState  {
  final bool loading;
  final List<Comment> comments;
  final String error;

  CommentsState({
    this.loading = false,
    this.comments,
    this.error,
  });

  CommentsState copyWith({
    bool loading,
    List<Comment> comments,
    String error,
  }) {
    return new CommentsState(
      loading: loading ?? this.loading,
      comments: comments ?? this.comments,
      error: error ?? this.error,
    );
  }
}
