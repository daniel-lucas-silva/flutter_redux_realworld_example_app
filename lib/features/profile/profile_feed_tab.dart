import 'dart:async';

import 'package:conduite/components.dart';
import 'package:conduite/features/profile/profile_screen.dart';
import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ViewModel {
  final List<Article> articles;
  final bool isLoggedIn;
  final dispatch;

  _ViewModel(this.articles, this.dispatch, this.isLoggedIn);
}

class ProfileFeedTab extends StatefulWidget {
  final bool favorited;

  const ProfileFeedTab({
    Key key,
    this.favorited = false,
  }) : super(key: key);

  @override
  _ProfileFeedTabState createState() => _ProfileFeedTabState();
}

class _ProfileFeedTabState extends State<ProfileFeedTab> with AutomaticKeepAliveClientMixin {
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
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        store.dispatch(loadArticles(
          context,
          isFeed: !widget.favorited,
        ));
      },
      converter: (store) {
        return _ViewModel(
          widget.favorited
              ? store.state.articles.global
              : store.state.articles.feed,
          store.dispatch,
          store.state.auth.user != null,
        );
      },
      builder: (context, vm) {
        return RefreshIndicator(
          onRefresh: () {
            final completer = new Completer();
            vm.dispatch(loadArticles(
              context,
              isFeed: !widget.favorited,
              completer: completer,
            ));
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
                  onAuthorTap: () {
                    navigateTo(context, ProfileScreen());
                  },
                  name: article.author.username,
                  date: DateTime.parse(article.createdAt),
                  image: getImage(article.author.image),
                  favorited: vm.isLoggedIn ? article.favorited : false,
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
