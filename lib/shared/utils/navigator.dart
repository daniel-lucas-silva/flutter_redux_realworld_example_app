part of utils;

Future<T> navigateTo<T>(context, Widget screen) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

Future<T> resetTo<T>(context, Widget screen) {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => screen),
    (_) => false,
  );
}
