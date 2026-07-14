import 'dart:io';

import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/button.dart';
import 'package:ava/core/models/media_page_params.dart';
import 'package:ava/core/models/message_model.dart';
import 'package:ava/core/providers/chat_provider.dart';
import 'package:ava/core/providers/socket_provider.dart';
import 'package:ava/core/utils/pickers.dart';
import 'package:ava/core/utils/typewriter.dart';
import 'package:intl/intl.dart' hide TextDirection;

part 'widgets/appbar.dart';
part 'widgets/bubble.dart';
part 'widgets/chat_field.dart';
part 'widgets/content.dart';
part 'widgets/message_content.dart';
part 'widgets/reply_preview.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      appbarHeight: 45.h,
      title: const _AppBar(),
      body: const _Content(),
      footer: const _ChatField(),
    );
  }
}
