import 'dart:async';

import 'package:conduite/components.dart';
import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ViewModel {
  final List<Article> articles;
  final dispatch;

  _ViewModel(this.articles, this.dispatch);
}

class FeedTab extends StatefulWidget {
  final bool isGlobal;

  const FeedTab({
    Key key,
    this.isGlobal = false,
  }) : super(key: key);

  @override
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> with AutomaticKeepAliveClientMixin {
  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(converter: (store) {
      return _ViewModel(
        widget.isGlobal
            ? store.state.articles.global
            : store.state.articles.feed,
        store.dispatch,
      );
    }, builder: (context, vm) {
      return RefreshIndicator(
        onRefresh: () {
          final completer = new Completer();
          vm.dispatch(loadArticles(context,
              isFeed: !widget.isGlobal, completer: completer));
          return completer.future;
        },
        child: ListView.builder(
          cacheExtent: 340,
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: vm.articles?.length ?? 0,
          itemBuilder: (context, index) {
            final Article article = vm.articles[index];

            return ArticleTile(
              head: ArticleTileHead(
                onAuthorTap: () {},
                name: article.author.username,
                date: DateTime.parse(article.createdAt),
                image: getImage(article.author.image),
                favorited: article.favorited,
                favoritesCount: article.favoritesCount,
                onFavoriteTap: () {},
              ),
              body: ArticleTileBody(
                title: article.title,
                description: article.description,
              ),
              foot: ArticleTileFoot(
                onTap: () {},
                tags: article.tags
                    .map((t) => Tag(
                          child: Text(t),
                          onTap: () {},
                        ))
                    .toList(),
              ),
            );
          },
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
