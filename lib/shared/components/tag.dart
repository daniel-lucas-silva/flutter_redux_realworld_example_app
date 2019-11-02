part of components;

class Tag extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const Tag({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: onTap,
        child: DefaultTextStyle(
          style: Styles.tag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
            child: child,
          ),
        ),
      ),
    );
  }
}
