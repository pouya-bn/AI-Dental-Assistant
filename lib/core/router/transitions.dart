part of 'router.dart';

Page<dynamic> Function(
  BuildContext,
  GoRouterState,
) _pageBuilder<T>(Widget child) {
  return (BuildContext context, GoRouterState state) {
    return _customPageBuilder(
      context,
      state,
      child: child,
    );
  };
}

CustomTransitionPage<T> _customPageBuilder<T>(
  BuildContext context,
  GoRouterState state, {
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: _fadeSlideTransition,
  );
}

Widget _fadeSlideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final secondaryFadeTween = Tween<double>(begin: 0, end: 1);
  final secondarySlideTween = Tween<Offset>(
    begin: const Offset(-0.5, 0),
    end: Offset.zero,
  );
  return FadeTransition(
    opacity: secondaryFadeTween.animate(animation),
    child: SlideTransition(
      position: secondarySlideTween.animate(animation),
      child: child,
    ),
  );
}
