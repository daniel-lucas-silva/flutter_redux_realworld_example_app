import 'package:conduite/components.dart';
import 'package:conduite/config.dart';
import 'package:conduite/models.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Author author;

  const ProfileScreen({
    Key key,
    @required this.author,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.grey[300],
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: getImage(widget.author.image),
              ),
              SizedBox(width: 10),
              Text(widget.author.username, style: Styles.h4)
            ],
          ),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {},
              label: Text("Follow"),
              icon: Icon(ConduiteIcons.add),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Container(
              color: Colors.white,
              child: TabBar(
                tabs: <Widget>[
                  Tab(text: "Articles"),
                  Tab(text: "Favorited"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
