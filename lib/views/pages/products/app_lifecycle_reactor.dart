import 'package:flutter/material.dart';

class AppLifecycleReactor extends StatefulWidget {
  final Widget child;
  final Function(AppLifecycleState) onHandleAppLifecycle;

  const AppLifecycleReactor(
      {Key? key, required this.onHandleAppLifecycle, required this.child})
      : super(key: key);

  @override
  _AppLifecycleReactorState createState() => _AppLifecycleReactorState();
}

class _AppLifecycleReactorState extends State<AppLifecycleReactor>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.onHandleAppLifecycle(state);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
