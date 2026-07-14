part of '../chat_page.dart';

class _Bubble extends HookConsumerWidget {
  const _Bubble({
    required this.message,
  });

  final AvaMessageModel message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeSent =
        DateFormat.Hm().format(message.createdAt ?? DateTime.now());
    final shouldShowButtons =
        ref.watch(buttonsProvider.notifier).shouldShowButtons(message.id);
    return Align(
      alignment:
          message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.width - 110.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: message.isUserMessage
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 5.h),
              decoration: BoxDecoration(
                color: message.isUserMessage ? Colors.white : AppColors.blue5,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MessageContent(
                    message: message,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.isUserMessage) ...[
                        Icon(
                          Icons.done_all,
                          color: AppColors.blue10,
                          size: 15.sp,
                        ),
                        SizedBox(width: 5.w),
                      ],
                      Text(
                        timeSent,
                        style: context.bodySmall.copyWith(
                          color: AppColors.blue10,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (message.buttons != null && message.buttons!.isNotEmpty) ...[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  );
                },
                child: shouldShowButtons
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5.w,
                          children: message.buttons!
                              .map(
                                (button) => CustomButton.outlined(
                                  label: button,
                                  size: const Size.fromHeight(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  borderColor: AppColors.blue10,
                                  labelStyle: context.bodySmall.copyWith(
                                    color: AppColors.primary,
                                  ),
                                  onTap: () {
                                    if (button == 'ذخیره به صورت PDF') {
                                      ref
                                          .read(chatProvider.notifier)
                                          .saveAsPdf(message);
                                      return;
                                    }
                                    ref
                                        .read(chatProvider.notifier)
                                        .sendText(button);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
