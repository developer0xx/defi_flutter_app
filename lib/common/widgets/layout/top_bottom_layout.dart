import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:sapiency_app/common/constants/app_values.dart';

class TopBottomLayout extends StatelessWidget {
  final Widget? top;
  final Widget? bottom;
  final ScrollController? scrollController;

  const TopBottomLayout({
    this.top,
    this.bottom,
    this.scrollController,
  });

  @override
  Widget build(BuildContext ctx) {
    return KeyboardSizeProvider(
      child: Consumer<ScreenHeight>(
        builder: (context, _res, child) {
          return LayoutBuilder(
            builder: (context, constraint) {
              return MediaQuery.removePadding(
                context: ctx,
                removeTop: true,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraint.maxHeight + _res.keyboardHeight,
                      minWidth: constraint.maxWidth,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: AppValues.screenPadding,
                        child: Column(
                          children: <Widget>[
                            Expanded(child: top ?? SizedBox.shrink()),
                            bottom ?? SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
