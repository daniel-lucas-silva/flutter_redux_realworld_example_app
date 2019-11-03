part of components;

class ArticleTile extends StatelessWidget {
  final ArticleTileHead head;
  final ArticleTileBody body;
  final ArticleTileFoot foot;

  const ArticleTile({
    Key key,
    @required this.head,
    @required this.body,
    @required this.foot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          head,
          body,
          foot,
        ],
      ),
    );
  }
}

class ArticleTileHead extends StatelessWidget {
  final String name;
  final DateTime date;
  final ImageProvider image;
  final bool favorited;
  final int favoritesCount;
  final VoidCallback onFavoriteTap;
  final VoidCallback onAuthorTap;

  const ArticleTileHead({
    Key key,
    @required this.name,
    @required this.date,
    this.image,
    this.favorited,
    this.favoritesCount,
    this.onFavoriteTap,
    this.onAuthorTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: image ?? AssetImage('images/smiley-cyrus.jpg'),
          ),
          onTap: onAuthorTap,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: onAuthorTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(name, style: Styles.link),
                  Text(DateFormat("EEE MMM d yyyy").format(date),
                      style: Styles.text),
                ],
              ),
            ),
          ),
        ),
        FavoriteButton(
          favorited: favorited ?? false,
          count: favoritesCount ?? 0,
          onTap: onFavoriteTap,
        ),
      ],
    );
  }
}

class ArticleTileBody extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ArticleTileBody({
    Key key,
    @required this.title,
    @required this.description,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title ?? '', style: Styles.h3),
            Text(description ?? '', style: Styles.h5),
          ],
        ),
      ),
    );
  }
}

class ArticleTileFoot extends StatelessWidget {
  final VoidCallback onTap;
  final List<Tag> tags;

  const ArticleTileFoot({
    Key key,
    this.onTap,
    this.tags: const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          child: Text("Read more...", style: Styles.text),
          onTap: onTap,
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            children: tags,
          ),
        ),
      ],
    );
  }
}
