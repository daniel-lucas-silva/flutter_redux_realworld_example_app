part of config;

final iconWhite = IconThemeData(color: Colors.white);

final theme = ThemeData(
  primarySwatch: ConduiteColors.green,
  buttonColor: ConduiteColors.green,
  appBarTheme: AppBarTheme(
    iconTheme: iconWhite,
    actionsIconTheme: iconWhite,
    textTheme: TextTheme(
      title: TextStyle(color: Colors.white, fontSize: 20)
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder()
  ),
);
