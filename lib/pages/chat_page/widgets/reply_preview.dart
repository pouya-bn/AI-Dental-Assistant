part of '../chat_page.dart';

// class _MessageReplyPreview extends ConsumerWidget {
//   const _MessageReplyPreview();
//
//   void cancelReply(WidgetRef ref) {
//     ref.read(replyProvider.notifier).set(null);
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final reply = ref.watch(replyProvider);
//     return Container(
//       width: 350,
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12),
//           topRight: Radius.circular(12),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   reply!.isSelf ? 'Me' : 'Opposite',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 child: const Icon(
//                   Icons.close,
//                   size: 16,
//                 ),
//                 onTap: () => cancelReply(ref),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           _MessageContent(
//             content: reply.message,
//             type: reply.type,
//           ),
//         ],
//       ),
//     );
//   }
// }
