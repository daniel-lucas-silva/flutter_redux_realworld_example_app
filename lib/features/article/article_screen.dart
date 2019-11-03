import 'package:conduite/components.dart';
import 'package:conduite/config.dart';
import 'package:conduite/features/article/comment_list.dart';
import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import 'comment_form.dart';

class ArticleScreen extends StatefulWidget {
  ArticleScreen(this.article);

  final Article article;

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  TrackingScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          store.state.auth.user,
          store.dispatch,
        );
      },
      builder: (context, _ViewModel vm) {
        return Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: <Widget>[
                  CustomScrollView(
                    controller: _controller,
                    slivers: <Widget>[
                      buildAppBar(),
                      buildTitle(),
                      buildBody(),
                      SliverPadding(
                        padding: EdgeInsets.only(bottom: vm.user != null ? 40 : 0),
                        sliver: buildComments(),
                      ),
                    ],
                  ),
                  if(vm.user != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CommentForm(widget.article.slug, vm.user),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  buildAppBar() {
    final appBarTheme = Theme.of(context).appBarTheme;

    return SliverAppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey[900],
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage("${widget.article.author.image}"),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.article.author.username,
                style: appBarTheme.textTheme.body1,
              ),
              Text(
                DateFormat("EEE MMM d yyyy").format(widget.article.createdAt),
                style: Styles.text,
              ),
            ],
          )
        ],
      ),
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        )
      ],
    );
  }

  buildBody() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: ConduiteColors.border),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MarkdownBody(
              data: widget.article.body,
//          styleSheet: markdownStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Wrap(
                children: widget.article.tags
                    .map<Tag>((t) => Tag(
                          child: Text(t),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildTitle() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 10),
        child: Text(
          widget.article.title,
          style: Styles.h2.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  buildComments() {
    return SliverPadding(
      padding: EdgeInsets.all(15),
      sliver: CommentList(widget.article.slug),
    );
  }
}

class _ViewModel {
  final User user;
  final Dispatch dispatch;

  _ViewModel(this.user, this.dispatch);
}
