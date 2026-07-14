import 'dart:async';

import 'package:ava/common/values/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void useInterval(Duration delay, VoidCallback callback) {
  final savedCallback = useRef(callback);
  savedCallback.value = callback;
  useEffect(() {
    final timer = Timer.periodic(delay, (_) => savedCallback.value());
    return timer.cancel;
  }, [delay]);
}

void useAfterLayout(BuildContext context, VoidCallback callback,
    [List<Object?>? keys]) {
  useEffect(() {
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (context.mounted) callback();
    });
    return null;
  }, keys);
}

Offset useOffset(BuildContext context, GlobalKey key) {
  final offset = useState(Offset.zero);
  useAfterLayout(context, () {
    offset.value = Offset(key.dx, key.dy);
  }, [key]);
  return offset.value;
}

AutoScrollController useAutoScrollController() {
  final controller = useMemoized(() => AutoScrollController());
  useEffect(() {
    return () => controller.dispose();
  }, [controller]);
  return controller;
}

void useDebouncedSearch(
  TextEditingController controller, {
  Duration timeout = const Duration(milliseconds: 500),
  required void Function(String searchTerm) onDebounce,
}) {
  final query = useState('');
  useEffect(() {
    controller.addListener(() {
      query.value = controller.text;
    });
    return null;
  }, []);

  final debouncedQuery = useDebounced(query.value, timeout);
  final interacted = useState(false);

  useEffect(() {
    if (debouncedQuery != null) {
      WidgetsBinding.instance.endOfFrame.then((_) {
        if (debouncedQuery.isEmpty) {
          if (interacted.value) {
            onDebounce(debouncedQuery);
          }
        } else {
          interacted.value = true;
          onDebounce(debouncedQuery);
        }
      });
    }
    return null;
  }, [debouncedQuery]);
}

// AnimatedMapController useAnimatedMapController() {
//   final tickerProvider = useSingleTickerProvider();
//   final controller = useMemoized(
//     () => AnimatedMapController(vsync: tickerProvider),
//     [tickerProvider],
//   );
//   useEffect(() {
//     return () => controller.dispose();
//   }, [controller]);
//   return controller;
// }

// FlutterSoundRecorder useFlutterSoundRecorder() {
//   final recorder = useMemoized(() => FlutterSoundRecorder());
//   useEffect(() {
//     return () => recorder.closeRecorder();
//   }, [recorder]);
//   return recorder;
// }
