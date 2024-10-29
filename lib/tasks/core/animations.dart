import 'package:flutter/material.dart';

class NoAnimationTransition extends MaterialPageRoute {
  NoAnimationTransition({required super.builder, RouteSettings? routeSettings})
      : super(
          maintainState: true,
          fullscreenDialog: false,
        );
  @override
  Duration get transitionDuration => Duration.zero;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (animation.status == AnimationStatus.reverse) {
    //   return FadeTransition(
    //     opacity: animation,
    //     child: child,
    //   );
    // }
    return child;
  }
}
