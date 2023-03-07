part of auto_size_text;

class AutoSizeGroupBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, AutoSizeGroup autoSizeGroup) builder;

  const AutoSizeGroupBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  _AutoSizeGroupBuilderState createState() => _AutoSizeGroupBuilderState();
}

class _AutoSizeGroupBuilderState extends State<AutoSizeGroupBuilder> {
  final _group = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _group);
  }
}
