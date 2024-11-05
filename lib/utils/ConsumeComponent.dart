import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ConsumeComponent<T extends ChangeNotifier> extends StatefulWidget {
  final T? model;
  final Widget? child;
  final ValueWidgetBuilder<T>? builder;

  ConsumeComponent({
    Key? key,
    @required this.model,
    @required this.builder,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConsumeComponentState<T>();
}

class _ConsumeComponentState<T extends ChangeNotifier>
    extends State<ConsumeComponent<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model!,
      child: Consumer<T>(
        child: widget.child,
        builder: widget.builder!,
      ),
    );
  }
}
