part of config;

abstract class Styles {
  static const base = TextStyle(fontSize: 12);
  static const defaultColor = Colors.white;

  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 16,
    color: Colors.black54,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h5 = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle text = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  static TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ConduiteColors.green,
  );
  static const TextStyle linkLight = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle appBarLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const TextStyle tag = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );
}
