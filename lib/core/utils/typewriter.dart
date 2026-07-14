import 'dart:async';

import 'package:ava/common/values/imports.dart';

class TypeWriter extends HookWidget {
  final String text;
  final TextStyle? style;
  final TextDirection textDirection;
  final Duration duration;
  final VoidCallback? onTypeEnd;

  const TypeWriter(this.text, {
    super.key,
    this.style,
    this.textDirection = TextDirection.rtl,
    this.duration = const Duration(milliseconds: 70),
    this.onTypeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final displayedText = useState('');
    final index = useState(0);
    final isTypingComplete = useState(false);

    useEffect(() {
      if (isTypingComplete.value) return null;

      final timer = Timer.periodic(duration, (timer) {
        if (index.value < text.length) {
          displayedText.value += text[index.value];
          index.value++;
        } else {
          timer.cancel();
          isTypingComplete.value = true;
          if (onTypeEnd != null) {
            onTypeEnd!();
          }
        }
      });

      return timer.cancel;
    }, [text]);

    return Text(
      displayedText.value,
      style: style,
      textDirection: textDirection,
    );
  }
}
