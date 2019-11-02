part of config;

abstract class ConduiteColors {

  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFEBF6EB),
      100: Color(0xFFCEEACE),
      200: Color(0xFFAEDCAE),
      300: Color(0xFF8DCD8D),
      400: Color(0xFF74C374),
      500: Color(_greenPrimaryValue),
      600: Color(0xFF54B154),
      700: Color(0xFF4AA84A),
      800: Color(0xFF41A041),
      900: Color(0xFF309130),
    },
  );
  static const int _greenPrimaryValue = 0xFF5CB85C;

  static const MaterialAccentColor greenAccent = MaterialAccentColor(
    _greenAccentValue,
    <int, Color>{
      100: Color(0xFFD9FFD9),
      200: Color(_greenAccentValue),
      400: Color(0xFF73FF73),
      700: Color(0xFF59FF59),
    },
  );
  static const int _greenAccentValue = 0xFFA6FFA6;
}
