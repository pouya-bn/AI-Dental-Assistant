import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CustomTabBarView<T> extends StatefulWidget {
  const CustomTabBarView({
    super.key,
    required this.autoScrollController,
    required this.tabController,
    required this.header,
    required this.body,
    required this.itemBuilder,
    this.separatorBuilder,
    this.verticalScrollPosition = CustomTabBarViewPosition.start,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
  });

  final TabController tabController;
  final List<Widget> header;
  final List<T> body;
  final Widget Function(T item, int index) itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final CustomTabBarViewPosition verticalScrollPosition;
  final AutoScrollController autoScrollController;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final Key? center;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  @override
  State<CustomTabBarView<T>> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState<T> extends State<CustomTabBarView<T>>
    with SingleTickerProviderStateMixin {
  final listKey = RectGetter.createGlobalKey();
  Map<int, GlobalKey<RectGetterState>> itemsKeys = {};

  @override
  void initState() {
    widget.tabController.addListener(_handleTabControllerTick);
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabControllerTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RectGetter(
      key: listKey,
      child: NotificationListener<UserScrollNotification>(
        onNotification: _onScrollNotification,
        child: CustomScrollView(
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          controller: widget.autoScrollController,
          primary: widget.primary,
          physics: widget.physics,
          scrollBehavior: widget.scrollBehavior,
          shrinkWrap: widget.shrinkWrap,
          center: widget.center,
          anchor: widget.anchor,
          cacheExtent: widget.cacheExtent,
          slivers: [...widget.header, _buildSliverList()],
          semanticChildCount: widget.semanticChildCount,
          dragStartBehavior: widget.dragStartBehavior,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          restorationId: widget.restorationId,
          clipBehavior: widget.clipBehavior,
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList.separated(
      itemCount: widget.body.length,
      itemBuilder: (context, index) {
        itemsKeys[index] = RectGetter.createGlobalKey();
        return _buildItem(index);
      },
      separatorBuilder: (context, index) {
        return widget.separatorBuilder != null
            ? widget.separatorBuilder!(context, index)
            : null;
      },
    );
  }

  Widget _buildItem(int index) {
    T item = widget.body[index];
    return RectGetter(
      key: itemsKeys[index]!,
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: widget.autoScrollController,
        child: widget.itemBuilder(item, index),
      ),
    );
  }

  void _animateAndScrollTo(int index) async {
    widget.tabController.animateTo(index);
    switch (widget.verticalScrollPosition) {
      case CustomTabBarViewPosition.start:
        widget.autoScrollController.scrollToIndex(
          index,
          preferPosition: AutoScrollPosition.begin,
        );
        break;
      case CustomTabBarViewPosition.middle:
        widget.autoScrollController.scrollToIndex(
          index,
          preferPosition: AutoScrollPosition.middle,
        );
        break;
      case CustomTabBarViewPosition.end:
        widget.autoScrollController.scrollToIndex(
          index,
          preferPosition: AutoScrollPosition.end,
        );
        break;
    }
  }

  bool _onScrollNotification(UserScrollNotification notification) {
    List<int> visibleItems = _getVisibleItemsIndex();
    widget.tabController.animateTo(visibleItems[0]);
    return false;
  }

  List<int> _getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listKey);
    List<int> items = [];
    if (rect == null) return items;

    bool isHorizontalScroll = widget.scrollDirection == Axis.horizontal;
    itemsKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      switch (isHorizontalScroll) {
        case true:
          if (itemRect.left > rect.right) return;
          if (itemRect.right < rect.left) return;
          break;
        case false:
          if (itemRect.top > rect.bottom) return;
          if (itemRect.bottom <
              rect.top +
                  MediaQuery.of(context).viewPadding.top +
                  kToolbarHeight +
                  56) return;
          break;
      }
      items.add(index);
    });
    return items;
  }

  void _handleTabControllerTick() {
    if (CustomTabBarViewStatus.isOnTap) {
      CustomTabBarViewStatus.isOnTap = false;
      _animateAndScrollTo(CustomTabBarViewStatus.isOnTapIndex);
    }
  }
}

class CustomTabBarViewStatus {
  static bool isOnTap = false;
  static int isOnTapIndex = 0;

  static void setIndex(int index) {
    CustomTabBarViewStatus.isOnTap = true;
    CustomTabBarViewStatus.isOnTapIndex = index;
  }
}

enum CustomTabBarViewPosition {
  start,
  middle,
  end,
}
