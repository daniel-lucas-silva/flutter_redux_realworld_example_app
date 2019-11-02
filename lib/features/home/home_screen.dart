import 'package:conduite/components.dart';
import 'package:conduite/features/auth/sign_in_screen.dart';
import 'package:conduite/features/home/settings_tab.dart';
import 'package:conduite/features/home/feed_tab.dart';
import 'package:conduite/models.dart';
import 'package:conduite/services.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ViewModel {
  final int index;
  final User user;
  final dynamic dispatch;

  _ViewModel({
    this.index,
    this.user,
    this.dispatch,
  });
}

class _TabItem {
  final String title;
  final Widget screen;
  final IconData icon;

  _TabItem({this.title, this.screen, this.icon});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller;
  List<_TabItem> _tabs;

  @override
  void initState() {
    _controller = PageController(keepPage: true);
    _tabs = [
      _TabItem(
        title: "Global Feed",
        screen: FeedTab(isGlobal: true),
        icon: ConduiteIcons.global,
      ),
      _TabItem(
        title: "Your Feed",
        screen: FeedTab(),
        icon: ConduiteIcons.feed,
      ),
      _TabItem(
        title: "Settings",
        screen: SettingsTab(),
        icon: ConduiteIcons.cog,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        if (store.state.auth.isAuthenticated)
          api.setToken(store.state.auth.user.token);
      },
      converter: (store) {
        return _ViewModel(
          index: store.state.index,
          dispatch: store.dispatch,
          user: store.state.auth.user,
        );
      },
      builder: (context, _vm) {
        return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text("Conduite"),
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: ImageIcon(AssetImage('images/github.png')),
              onPressed: () => navigateTo(context, SignInScreen()),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(ConduiteIcons.account, size: 27),
                onPressed: () => navigateTo(context, SignInScreen()),
              ),
            ],
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: _vm.user != null
              ? Visibility(
                visible: _vm.index != 2,
                child: FloatingActionButton(
                    child: Icon(ConduiteIcons.add, color: Colors.white),
                    onPressed: () {},
                  ),
              )
              : null,
          bottomNavigationBar: _vm.user != null
              ? CupertinoTabBar(
                  currentIndex: _vm.index,
                  backgroundColor: Colors.white,
                  onTap: (idx) {
                    _controller.jumpToPage(idx);
                    _vm.dispatch(new ChangeIndex(idx));
                  },
                  items: _tabs.map<BottomNavigationBarItem>((t) {
                    return BottomNavigationBarItem(
                      icon: Icon(t.icon),
                      title: Text(t.title),
                    );
                  }).toList(),
                )
              : null,
          body: _vm.user != null
              ? PageView.builder(
                  controller: _controller,
                  itemCount: _tabs.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => _tabs[index].screen,
                )
              : FeedTab(isGlobal: true),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: InkWell(
              child: Image.asset(
                'images/smiley-cyrus.jpg',
                height: 34,
                width: 34,
              ),
              onTap: () {},
            ),
          ),
        )
      ],
    );
  }
}
