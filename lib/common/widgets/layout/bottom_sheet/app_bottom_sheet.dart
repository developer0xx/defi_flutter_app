import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final Color backgroundColor;
  final Widget Function(BuildContext) builder;

  const AppBottomSheet({
    required this.builder,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: backgroundColor,
      ),
      padding: EdgeInsets.only(top: 12, bottom: 0, left: 32, right: 32),
      child: builder(context),
    );
  }
}
