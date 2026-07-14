part of '../chat_page.dart';

class _ChatField extends HookConsumerWidget {
  const _ChatField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final menuOpen = useState(false);
    // void openMenu() => menuOpen.value = true;
    // void closeMenu() => menuOpen.value = false;

    // void selectMedia() async {
    //   File? imageFile = await pickImage();
    //   if (imageFile != null) {
    //     ref.read(chatProvider.notifier).sendPicture(imageFile);
    //   }
    // }

    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
        left: 10.w,
        right: 10.w,
        bottom: context.mediaQuery.padding.bottom + 10.h,
      ),
      color: AppColors.blue5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.blue8,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      // SizedBox(
                      //   width: 57.w,
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: _IconButton(
                      //       onTap: menuOpen.value ? closeMenu : openMenu,
                      //       width: menuOpen.value ? 57.w : null,
                      //       icon: menuOpen.value
                      //           ? 'assets/images/svg/close-menu.svg'
                      //           : 'assets/images/svg/add-circle.svg',
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          // onTap: menuOpen.value ? closeMenu : openMenu,
                          child: Text(
                            'گزینه مورد نظر خود را انتخاب کنید',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: context.labelSmall.copyWith(
                              color: AppColors.onSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 57.w,
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: _IconButton(
                      //       onTap: selectMedia,
                      //       icon: 'assets/images/svg/attach.svg',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 8.w),
              // _IconButton(
              //   onTap: showSendButton.value ? sendTextMessage : () {},
              //   icon: showSendButton.value
              //       ? 'assets/images/svg/send2.svg'
              //       : recording.value
              //           ? 'assets/images/svg/close_circle_outline.svg'
              //           : 'assets/images/svg/microphone.svg',
              // ),
            ],
          ),
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 200),
          //   transitionBuilder: (child, animation) {
          //     return SizeTransition(
          //       sizeFactor: animation,
          //       child: child,
          //     );
          //   },
          //   child: menuOpen.value
          //       ? Padding(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: 10.w,
          //             vertical: 10.h,
          //           ),
          //           child: Column(
          //             children: [
          //               CustomButton(
          //                 label: 'خانه',
          //                 height: 40.h,
          //                 width: double.maxFinite,
          //                 color: AppColors.blue8,
          //                 labelColor: AppColors.onSecondary,
          //                 margin: EdgeInsets.zero,
          //                 onTap: () {},
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: CustomButton(
          //                       label: 'یادآور',
          //                       height: 40.h,
          //                       color: AppColors.blue8,
          //                       labelColor: AppColors.onSecondary,
          //                       onTap: () {},
          //                     ),
          //                   ),
          //                   SizedBox(width: 10.w),
          //                   Expanded(
          //                     child: CustomButton(
          //                       label: 'معاینه هوشمند',
          //                       height: 40.h,
          //                       color: AppColors.blue8,
          //                       labelColor: AppColors.onSecondary,
          //                       onTap: () {},
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         )
          //       : null,
          // ),
        ],
      ),
    );
  }
}

// class _IconButton extends StatelessWidget {
//   const _IconButton({
//     required this.icon,
//     required this.onTap,
//     this.width,
//   });
//
//   final String icon;
//   final VoidCallback onTap;
//   final double? width;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40.h,
//       width: width ?? 40.h,
//       child: IconButton(
//         onPressed: onTap,
//         style: IconButton.styleFrom(
//           highlightColor: AppColors.highlight,
//         ),
//         icon: CustomSvg(
//           icon,
//           color: AppColors.onSecondary,
//           height: 24.h,
//           width: width != null ? null : 24.h,
//         ),
//       ),
//     );
//   }
// }
