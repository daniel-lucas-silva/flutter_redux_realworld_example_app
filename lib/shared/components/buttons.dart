part of components;

const kButtonPadding = const EdgeInsets.symmetric(vertical: 17, horizontal: 13);

class Button extends RawButton {
  Button({
    Widget leading,
    Widget trailing,
    Widget child,
    bool loading,
    @required VoidCallback onPressed,
    EdgeInsets padding,
    Color color,
    Color textColor,
    Color iconColor,
    double iconSize,
    ShapeBorder shape,
    Clip clipBehavior,
  }) : super(
          leading: leading,
          trailing: trailing,
          child: child,
          loading: loading ?? false,
          onPressed: onPressed,
          padding: padding ?? kButtonPadding,
          color: color,
          textColor: textColor,
          iconColor: iconColor,
          iconSize: iconSize ?? 20,
          shape: shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          clipBehavior: clipBehavior ?? Clip.antiAlias,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RawButton(
      leading: leading,
      trailing: trailing,
      child: child,
      loading: loading,
      onPressed: onPressed,
      padding: padding,
      color: color ?? theme.buttonColor,
      textColor: textColor,
      iconColor: iconColor,
      iconSize: iconSize,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
}

class RawButton extends StatelessWidget {
  RawButton({
    this.loading = false,
    this.decoration = const BoxDecoration(),
    this.leading,
    this.child,
    this.trailing,
    @required this.onPressed,
    this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
    this.padding = kButtonPadding,
    this.color = const Color(0x00000000),
    this.splashColor,
    this.textColor,
    this.iconColor,
    this.iconSize = 20.0,
    this.shape = const RoundedRectangleBorder(),
    this.clipBehavior = Clip.none,
  });

  final BoxDecoration decoration;
  final bool loading;
  final Widget leading;
  final Widget child;
  final Widget trailing;
  final VoidCallback onPressed;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final Color splashColor;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final ShapeBorder shape;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final ButtonThemeData parentButtonTheme = ButtonTheme.of(context);

    return Container(
      margin: margin,
      child: Material(
        color: color,
        shape: shape,
        type: MaterialType.button,
        clipBehavior: clipBehavior,
        borderOnForeground: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: parentButtonTheme.minWidth ?? 64.0, minHeight: 52.0),
          child: InkWell(
            customBorder: shape,
            onTap: onPressed,
            splashColor: splashColor,
            child: Padding(
              padding: padding,
              child: IconTheme(
                data: IconTheme.of(context).copyWith(
                  size: iconSize,
                  color: iconColor ?? getContrastColor(color, brightness),
                ),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    getLeading(),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: textColor ?? getContrastColor(color, brightness),
                        fontSize: 14,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
                    getTrailing(brightness),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getContrastColor(Color color, Brightness brightness) {
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (brightness != Brightness.light && color.opacity < 0.5)
      return Color.fromRGBO(255, 255, 255, 1);
    else if (color.opacity < 0.5 || luminance > 0.5)
      return Color.fromRGBO(10, 10, 10, 1);
    else
      return Color.fromRGBO(255, 255, 255, 1);
  }

  getLeading() {
    if (leading != null)
      return Align(
        alignment: Alignment.centerLeft,
        child: leading,
      );
    else
      return Offstage();
  }

  getTrailing(brightness) {
    if (loading)
      return Align(
        alignment: Alignment.centerRight,
        child: ButtonSpinner(
          color: iconColor ?? getContrastColor(color, brightness),
          size: iconSize,
        ),
      );
    else if (trailing != null)
      return Align(
        alignment: Alignment.centerRight,
        child: trailing,
      );
    else
      return Offstage();
  }
}

class ButtonSpinner extends StatelessWidget {
  final Color color;
  final double size;

  ButtonSpinner({
    this.size = 24.0,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 2.1,
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool favorited;
  final int count;
  final VoidCallback onTap;

  const FavoriteButton({
    Key key,
    this.favorited = false,
    @required this.count,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Material(
      color: favorited ? color : Colors.transparent,
      type: MaterialType.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
          color: color,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                size: 13,
                color: favorited ? Colors.white : color,
              ),
              SizedBox(width: 5),
              Text(
                count.toString(),
                style: Styles.text.copyWith(
                  color: favorited ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AsyncButton<T> extends StatefulWidget {
  final Widget leading;
  final Widget trailing;
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final Future<T> Function(BuildContext context) builder;
  final void Function(T) onSuccess;
  final void Function(dynamic) onError;

  const AsyncButton({
    Key key,
    this.leading,
    this.trailing,
    this.padding = kButtonPadding,
    this.color,
    this.textColor,
    this.iconColor,
    this.iconSize = 20,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.child,
    @required this.builder,
    @required this.onSuccess,
    @required this.onError,
  }) : super(key: key);

  @override
  _AsyncButtonState createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Button(
      leading: widget.leading,
      trailing: widget.trailing,
      child: widget.child,
      loading: _loading,
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        try {
          await widget.builder(context).then(widget.onSuccess);
        } catch (e) {
          widget.onError(e);
        } finally {
          setState(() {
            _loading = false;
          });
        }
      },
      padding: widget.padding,
      color: widget.color ?? theme.buttonColor,
      textColor: widget.textColor,
      iconColor: widget.iconColor,
      iconSize: widget.iconSize,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
    );
  }
}
