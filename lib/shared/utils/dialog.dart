part of utils;

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
    context, Widget widget) {
  return Scaffold.of(context).showSnackBar(
    SnackBar(
      content: widget,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
