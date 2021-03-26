import 'package:flutter/material.dart';

class ConstraintsCanvas extends StatelessWidget {
  final Widget children;
  final double maxWidth;

  const ConstraintsCanvas(
      {Key key, this.maxWidth = 1200, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: this.maxWidth),
          child: Container(
            width: double.infinity,
            child: this.children,
          ),
        ),
      ),
    );
  }
}
