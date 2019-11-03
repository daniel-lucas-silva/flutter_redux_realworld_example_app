import 'package:conduite/components.dart';
import 'package:conduite/config.dart';
import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ViewModel {
  final dispatch;
  final List<Comment> comments;
  final bool loading;

  _ViewModel({
    this.dispatch,
    this.comments,
    this.loading,
  });
}

class CommentList extends StatefulWidget {
  CommentList(this.slug);

  final String slug;

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        store.dispatch(loadComments(context, widget.slug));
      },
      converter: (store) {
        return _ViewModel(
          dispatch: store.dispatch,
          comments: store.state.comments.comments ?? [],
          loading: store.state.comments.loading,
        );
      },
      builder: (context, vm) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Comments", style: Styles.h3),
                );
              }

              index -= 1;

              return CommentTile(vm.comments[index]);
            },
            childCount: vm.comments.length + 1,
          ),
        );
      },
    );
  }
}
