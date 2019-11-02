import 'package:conduite/config.dart';
import 'package:conduite/features/home/home_screen.dart';
import 'package:conduite/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final store = await createStore();

  runApp(Conduite(store));
}

class Conduite extends StatelessWidget {

  final Store<AppState> store;

  const Conduite(this.store);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Conduite',
          theme: theme,
          home: HomeScreen(),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
