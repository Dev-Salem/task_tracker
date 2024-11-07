import 'package:flutter/material.dart';

class NoAnimationTransition extends MaterialPageRoute {
  NoAnimationTransition({required super.builder, RouteSettings? routeSettings})
      : super(
          maintainState: false,
          fullscreenDialog: false,
        );
  @override
  Duration get transitionDuration => Duration.zero;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
