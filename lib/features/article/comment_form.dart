import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CommentForm extends StatefulWidget {
  CommentForm(this.slug, this.user);

  final String slug;
  final User user;

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Dispatch>(
      converter: (store) => store.dispatch,
      builder: (context, vm) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 48, maxHeight: 150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("${widget.user.image}"),
                    radius: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a comment...",
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _controller.text.isNotEmpty
                      ? () {
                          _controller.clear();
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final User user;
  final dispatch;

  _ViewModel({
    this.user,
    this.dispatch,
  });
}
