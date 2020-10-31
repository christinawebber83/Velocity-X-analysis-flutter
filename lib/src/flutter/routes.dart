import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

extension RoutesWidgetsExtension on Widget {
  CupertinoPageRoute cupertinoRoute({bool fullscreenDialog = false}) {
    /// Example:
    /// Navigator.push(context, YourPage().cupertinoRoute());
    ///
    return CupertinoPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (ctx) {
          return this;
        });
  }

  /// Example:
  /// Navigator.push(context, YourPage().materialRoute());
  ///
  MaterialPageRoute materialRoute({bool fullscreenDialog = false}) {
    return MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (ctx) {
          return this;
        });
  }

  /// Example:
  /// Navigator.push(context, YourPage().vxRoute());
  ///
  Route vxRoute({@required BuildContext parentContext}) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return this;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final rectAnimation = _createTween(parentContext)
            .chain(CurveTween(curve: Curves.ease))
            .animate(animation);

        return Stack(
          children: [
            PositionedTransition(rect: rectAnimation, child: child),
          ],
        );
      },
    );
  }

  Tween<RelativeRect> _createTween(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    final box = context.findRenderObject() as RenderBox;
    final rect = box.localToGlobal(Offset.zero) & box.size;
    final relativeRect = RelativeRect.fromSize(rect, windowSize);

    return RelativeRectTween(
      begin: relativeRect,
      end: RelativeRect.fill,
    );
  }
}
