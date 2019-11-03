part of components;

class CommentTile extends StatelessWidget {
  final Comment comment;

  CommentTile(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ConduiteColors.border),
        borderRadius: BorderRadius.circular(7)
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(13),
            child: Text("${comment.body}", style: Styles.text),
          ),
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: ConduiteColors.bgGrey,
              border: Border(
                top: BorderSide(color: ConduiteColors.border),
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage("${comment.author.image}"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("${comment.author.username}"),
                        Text("${comment.createdAt}", style: TextStyle(fontSize: 12, color: Colors.grey[600]),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
