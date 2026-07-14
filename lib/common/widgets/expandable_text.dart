import 'package:ava/common/values/imports.dart';
import 'package:flutter/gestures.dart';

enum TextTrimMode {
  length,
  line,
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.data, {
    super.key,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    this.trimExpandedText = 'کمتر',
    this.trimCollapsedText = 'بیشتر',
    this.colorClickableText = AppColors.primary,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TextTrimMode.line,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '$_kEllipsis ',
    this.delimiterStyle,
    this.callback,
    this.onLinkPressed,
    this.linkTextStyle,
  });

  /// Used on TrimMode.Length
  final int trimLength;

  /// Used on TrimMode.Lines
  final int trimLines;

  /// Determines the type of trim. TrimMode.Length takes into account
  /// the number of letters, while TrimMode.Lines takes into account
  /// the number of lines
  final TextTrimMode trimMode;

  /// TextStyle for expanded text
  final TextStyle? moreStyle;

  /// TextStyle for compressed text
  final TextStyle? lessStyle;

  /// TextSpan used before the data any heading or something
  final String? preDataText;

  /// TextSpan used after the data end or before the more/less
  final String? postDataText;

  /// TextSpan used before the data any heading or something
  final TextStyle? preDataTextStyle;

  /// TextSpan used after the data end or before the more/less
  final TextStyle? postDataTextStyle;

  ///Called when state change between expanded/compress
  final Function(bool val)? callback;

  final ValueChanged<String>? onLinkPressed;

  final TextStyle? linkTextStyle;

  final String delimiter;
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final TextScaler? textScaler;
  final String? semanticsLabel;
  final TextStyle? delimiterStyle;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
      widget.callback?.call(_readMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaler = widget.textScaler ?? MediaQuery.of(context).textScaler;
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;
    final defaultLessStyle = widget.lessStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultMoreStyle = widget.moreStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultDelimiterStyle = widget.delimiterStyle ?? effectiveTextStyle;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: _readMore ? defaultMoreStyle : defaultLessStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _readMore
          ? widget.trimCollapsedText.isNotEmpty
              ? widget.delimiter
              : ''
          : '',
      style: defaultDelimiterStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextSpan? preTextSpan;
        TextSpan? postTextSpan;
        if (widget.preDataText != null) {
          preTextSpan = TextSpan(
            text: "${widget.preDataText!} ",
            style: widget.preDataTextStyle ?? effectiveTextStyle,
          );
        }
        if (widget.postDataText != null) {
          postTextSpan = TextSpan(
            text: " ${widget.postDataText!}",
            style: widget.postDataTextStyle ?? effectiveTextStyle,
          );
        }

        // Create a TextSpan with data
        final text = TextSpan(
          children: [
            if (preTextSpan != null) preTextSpan,
            TextSpan(text: widget.data, style: effectiveTextStyle),
            if (postTextSpan != null) postTextSpan
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? widget.delimiter : null,
          locale: locale,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            textDirection == TextDirection.rtl
                ? readMoreSize
                : textSize.width - readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        TextSpan textSpan;
        switch (widget.trimMode) {
          case TextTrimMode.length:
            if (widget.trimLength < widget.data.length) {
              textSpan = _buildData(
                data: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          case TextTrimMode.line:
            if (textPainter.didExceedMaxLines) {
              textSpan = _buildData(
                data: _readMore
                    ? widget.data.substring(0, endIndex) +
                        (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return Text.rich(
          TextSpan(
            children: [
              if (preTextSpan != null) preTextSpan,
              textSpan,
              if (postTextSpan != null) postTextSpan,
            ],
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          overflow: TextOverflow.clip,
          textScaler: textScaler,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }

  TextSpan _buildData({
    required String data,
    TextStyle? textStyle,
    TextStyle? linkTextStyle,
    ValueChanged<String>? onPressed,
    required List<TextSpan> children,
  }) {
    RegExp exp = RegExp(r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+");

    List<TextSpan> contents = [];

    while (exp.hasMatch(data)) {
      final match = exp.firstMatch(data);

      final firstTextPart = data.substring(0, match!.start);
      final linkTextPart = data.substring(match.start, match.end);

      contents.add(
        TextSpan(
          text: firstTextPart,
        ),
      );
      contents.add(
        TextSpan(
          text: linkTextPart,
          style: linkTextStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onPressed?.call(
                  linkTextPart.trim(),
                ),
        ),
      );
      data = data.substring(match.end, data.length);
    }
    contents.add(
      TextSpan(
        text: data,
      ),
    );
    return TextSpan(
      children: contents..addAll(children),
      style: textStyle,
    );
  }
}

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// enum TrimType { lines, characters }
//
// class ExpandableText extends StatefulWidget {
//   /// Text to show
//   final String text;
//
//   /// Clickable text to display that expands text
//   final String readMoreText;
//
//   /// Clickable text to display that collapses text
//   final String readLessText;
//
//   /// [TextStyle] for both [readMoreText] and [readLessText]
//   final TextStyle? linkTextStyle;
//
//   /// [TextStyle] for [text]
//   final TextStyle? style;
//
//   final double? textScaleFactor;
//
//   /// For [TrimType.lines] this represents the maximum amount of lines allowable
//   /// before the text is collapsed
//   ///
//   /// For [TrimType.characters] this represents the number of characters
//   /// allowable before the text is collapsed
//   final int trim;
//
//   /// Whether to trim [text] by lines or characters in [text]
//   final TrimType trimType;
//
//   final TextAlign textAlign;
//
//   final TextDirection textDirection;
//
//   /// Callback function when a link is pressed
//   ///
//   /// Returns a boolean [true] is expanded and [false] is collapsed
//   final void Function(bool expanded)? onLinkPressed;
//
//   const ExpandableText(
//     this.text, {
//     super.key,
//     this.readLessText = 'کمتر',
//     this.readMoreText = 'بیشتر',
//     this.linkTextStyle,
//     this.textScaleFactor,
//     this.style,
//     this.trim = 2,
//     this.trimType = TrimType.lines,
//     this.textAlign = TextAlign.left,
//     this.textDirection = TextDirection.ltr,
//     this.onLinkPressed,
//   });
//
//   @override
//   State<ExpandableText> createState() => _ExpandableTextState();
// }
//
// class _ExpandableTextState extends State<ExpandableText> {
//   late TextSpan _text;
//   late TextSpan _linkText;
//   late TextSpan _ellipsisText;
//   late TextPainter _textPainter;
//   bool _isExpanded = false;
//
//   @override
//   void initState() {
//     _textPainter = TextPainter(
//       textDirection: widget.textDirection,
//       textAlign: widget.textAlign,
//       ellipsis: '...',
//       maxLines: widget.trim,
//     );
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _linkText = TextSpan(
//       text: _isExpanded ? widget.readLessText : widget.readMoreText,
//       style: widget.linkTextStyle ??
//           const TextStyle(
//             color: Colors.blue,
//             fontSize: 12,
//           ),
//       recognizer: TapGestureRecognizer()..onTap = _onLinkTextPressed,
//     );
//     _text = TextSpan(
//       text: widget.text,
//       style: widget.style ??
//           const TextStyle(
//             color: Colors.black,
//             fontSize: 12,
//           ),
//     );
//     _ellipsisText = TextSpan(
//       text: _isExpanded ? '  ' : '... ',
//       style: _text.style,
//     );
//
//     final textScaleFactor = widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
//
//     return LayoutBuilder(
//       builder: ((context, constraints) {
//         assert(
//           constraints.hasBoundedWidth,
//           'Parent width unbouded. A bounded width is required. Try wrapping '
//           'this widget with a Flexible or Expanded or use a Container with '
//           'a defined width.',
//         );
//         _textPainter.maxLines = widget.trim;
//
//         // layout and get size for link text
//         _textPainter.text = _linkText;
//         _textPainter.layout(
//           minWidth: constraints.minWidth,
//           maxWidth: constraints.maxWidth,
//         );
//         final linkSize = _textPainter.size;
//
//         // layout and get size for ellipsis text
//         _textPainter.text = _ellipsisText;
//         _textPainter.layout(
//           minWidth: constraints.minWidth,
//           maxWidth: constraints.maxWidth,
//         );
//         final ellipsisSize = _textPainter.size;
//
//         // layout and get size for text data
//         _textPainter.text = _text;
//         _textPainter.layout(
//           minWidth: constraints.minWidth,
//           maxWidth: constraints.maxWidth,
//         );
//         final textSize = _textPainter.size;
//
//         late final TextSpan textSpan;
//         bool hasOverflow = false;
//         int endIndex = 0;
//
//         switch (widget.trimType) {
//           case TrimType.lines:
//             // get the position of the data text minus the size of the link text
//             // minus ellipsis text size
//             final pos = _textPainter.getPositionForOffset(
//               Offset(
//                 textSize.width - linkSize.width - ellipsisSize.width,
//                 textSize.height,
//               ),
//             );
//             if (_textPainter.didExceedMaxLines) {
//               // get the index of the last 'seeable' character of the data text
//               endIndex = _textPainter.getOffsetBefore(pos.offset) ?? 0;
//               hasOverflow = true;
//             }
//             break;
//           case TrimType.characters:
//             if (widget.text.length >= widget.trim.abs()) {
//               endIndex = widget.trim;
//               hasOverflow = true;
//             }
//             break;
//         }
//
//         if (hasOverflow) {
//           textSpan = TextSpan(
//             children: [
//               TextSpan(
//                 text: _isExpanded
//                     ? widget.text
//                     : widget.text.substring(
//                         0,
//                         endIndex,
//                       ),
//                 style: _text.style,
//               ),
//               _ellipsisText,
//               _linkText,
//             ],
//           );
//         } else {
//           textSpan = _text;
//         }
//
//         return RichText(
//           text: textSpan,
//           textScaleFactor: textScaleFactor,
//         );
//       }),
//     );
//   }
//
//   Future<void> _onLinkTextPressed() async {
//     setState(() => _isExpanded = !_isExpanded);
//     if (widget.onLinkPressed != null) {
//       widget.onLinkPressed!(_isExpanded);
//     }
//   }
// }
