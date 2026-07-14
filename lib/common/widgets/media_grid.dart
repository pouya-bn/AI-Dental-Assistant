import 'package:ava/common/values/imports.dart';
import 'package:ava/core/models/media_page_params.dart';

class CustomMediaGrid extends StatelessWidget {
  const CustomMediaGrid({
    super.key,
    this.content,
    this.fallback,
    this.margin,
    this.gap,
    this.borderRadius,
  });

  final List<String>? content;
  final String? fallback;
  final EdgeInsets? margin;
  final double? gap;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final hasContent = content?.isNotEmpty ?? false;
    final borderRadius = this.borderRadius ?? 10.r;
    final gap = this.gap ?? 10.r;
    return Container(
      height: hasContent ? 216.h : null,
      width: double.maxFinite,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: hasContent
          ? switch (content!.length) {
              1 => _Content1(
                  content: content!,
                  gap: gap,
                  borderRadius: borderRadius,
                ),
              2 => _Content2(
                  content: content!,
                  gap: gap,
                  borderRadius: borderRadius,
                ),
              3 => _Content3(
                  content: content!,
                  gap: gap,
                  borderRadius: borderRadius,
                ),
              4 => _Content4(
                  content: content!,
                  gap: gap,
                  borderRadius: borderRadius,
                ),
              >= 5 => _Content5Plus(
                  content: content!,
                  gap: gap,
                  borderRadius: borderRadius,
                ),
              _ => const SizedBox.shrink(),
            }
          : InkWell(
              onTap: () {
                if (fallback != null) {
                  context.push(
                    AppRoutes.media,
                    extra: MediaPageParams(
                      image: AssetImage(fallback!),
                    ),
                  );
                }
              },
              child: SizedBox(
                height: 216.h,
                child: Image.asset(
                  fallback ?? 'assets/images/image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}

class _Media extends StatelessWidget {
  const _Media({
    required this.url,
    required this.borderRadius,
  });

  final String url;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CustomNetworkImage(
        url: url,
        onTap: () {
          context.push(
            AppRoutes.media,
            extra: MediaPageParams(
              image: customNetworkImageProvider(
                url: url,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Content1 extends StatelessWidget {
  const _Content1({
    required this.content,
    this.gap,
    required this.borderRadius,
  });

  final List<String> content;
  final double? gap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return _Media(
      url: content.first,
      borderRadius: borderRadius,
    );
  }
}

class _Content2 extends StatelessWidget {
  const _Content2({
    required this.content,
    this.gap,
    required this.borderRadius,
  });

  final List<String> content;
  final double? gap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _Media(
            url: content[0],
            borderRadius: borderRadius,
          ),
        ),
        SizedBox(width: gap),
        Expanded(
          child: _Media(
            url: content[1],
            borderRadius: borderRadius,
          ),
        ),
      ],
    );
  }
}

class _Content3 extends StatelessWidget {
  const _Content3({
    required this.content,
    this.gap,
    required this.borderRadius,
  });

  final List<String> content;
  final double? gap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _Media(
            url: content[0],
            borderRadius: borderRadius,
          ),
        ),
        SizedBox(height: gap),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Media(
                  url: content[1],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _Media(
                  url: content[2],
                  borderRadius: borderRadius,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Content4 extends StatelessWidget {
  const _Content4({
    required this.content,
    this.gap,
    required this.borderRadius,
  });

  final List<String> content;
  final double? gap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Media(
                  url: content[0],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _Media(
                  url: content[1],
                  borderRadius: borderRadius,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: gap),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Media(
                  url: content[2],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _Media(
                  url: content[3],
                  borderRadius: borderRadius,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Content5Plus extends StatelessWidget {
  const _Content5Plus({
    required this.content,
    this.gap,
    required this.borderRadius,
  });

  final List<String> content;
  final double? gap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Media(
                  url: content[0],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _Media(
                  url: content[1],
                  borderRadius: borderRadius,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: gap),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Media(
                  url: content[2],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _Media(
                  url: content[3],
                  borderRadius: borderRadius,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          content[4],
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (content.length > 5)
                        Container(
                          color: AppColors.blue6,
                          child: Center(
                            child: Text(
                              "+${content.length - 5} عکس",
                              style: context.labelMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
