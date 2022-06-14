import 'package:flutter/material.dart';

class PaddingCard extends StatelessWidget {
  final Widget widget;
  final Color? backgroundColor;
  const PaddingCard(this.widget,
      {Key? key, this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Card(
          color: backgroundColor,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: widget,
        ));
  }
}
