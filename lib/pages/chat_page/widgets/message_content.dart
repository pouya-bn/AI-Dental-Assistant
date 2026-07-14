part of '../chat_page.dart';

class _MessageContent extends HookConsumerWidget {
  const _MessageContent({
    required this.message,
  });

  final AvaMessageModel message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (message.type.toEnum) {
      case MessageType.text:
        return _Text(
          message: message,
        );
      case MessageType.picture:
        if (message.isUserMessage) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.file != null) ...[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        message.file!.path.split('/').last,
                        textDirection: TextDirection.ltr,
                        style: context.labelMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        message.file!.lengthSync().readable,
                        textDirection: TextDirection.ltr,
                        style: context.labelMedium.copyWith(
                          color: AppColors.blue10,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
              ],
              SizedBox(
                height: 74.h,
                width: 74.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: message.file != null
                      ? InkWell(
                          onTap: () {
                            context.push(
                              AppRoutes.media,
                              extra: MediaPageParams(
                                image: FileImage(message.file!),
                              ),
                            );
                          },
                          child: Image.file(
                            message.file!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CustomNetworkImage(
                          url: message.fileUrl,
                          onTap: () {
                            context.push(
                              AppRoutes.media,
                              extra: MediaPageParams(
                                image: customNetworkImageProvider(
                                  url: message.fileUrl,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CustomNetworkImage(
                  url: message.fileUrl,
                  onTap: () {
                    context.push(
                      AppRoutes.media,
                      extra: MediaPageParams(
                        image: customNetworkImageProvider(
                          url: message.fileUrl,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            _Text(
              message: message,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _Text extends ConsumerWidget {
  const _Text({
    required this.message,
  });

  final AvaMessageModel message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldType =
        ref.watch(typewriterProvider.notifier).shouldType(message.id);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.repliedTo != null) ...[
          Container(
            height: 60.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.blue11,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      message.repliedTo!.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelSmall.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.primary,
                  width: 5.w,
                  height: double.infinity,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
        if (!message.isUserMessage && shouldType)
          TypeWriter(
            message.message,
            onTypeEnd: () {
              // TODO: Handle onTypeEnd
              // ref.read(typewriterProvider.notifier).disableTyping(message.id);
              // ref.read(buttonsProvider.notifier).showButtons(message.id);
            },
            style: context.labelMedium.copyWith(
              color: Colors.white,
            ),
          )
        else
          Text(
            message.message,
            style: context.labelMedium.copyWith(
              color: message.isUserMessage ? AppColors.secondary : Colors.white,
            ),
          ),
      ],
    );
  }
}
