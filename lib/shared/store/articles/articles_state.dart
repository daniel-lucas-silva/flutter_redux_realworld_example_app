part of store;

@immutable
class ArticlesState  {
  final bool loading;
  final List<Article> global;
  final List<Article> feed;
  final String current;
  final String error;

  ArticlesState({
    this.loading = false,
    this.global,
    this.feed,
    this.current,
    this.error,
  });

  ArticlesState copyWith({
    bool loading,
    List<Article> global,
    List<Article> feed,
    String current,
    String error,
  }) {
    return new ArticlesState(
      loading: loading ?? this.loading,
      global: global ?? this.global,
      feed: feed ?? this.feed,
      current: current ?? this.current,
      error: error ?? this.error,
    );
  }

  factory ArticlesState.fromJSON(Map<String, dynamic> json) => new ArticlesState(
    loading: json['loading'],
    global: json['global'] != null ? serialize(json['global'], Article.fromJson) : null,
    feed: json['feed'] != null ? serialize(json['feed'], Article.fromJson) : null,
    current: json['current'],
    error: json['error'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'loading': this.loading,
    'global': this.global,
    'feed': this.feed,
    'current': this.current,
    'error': this.error,
  };
}
