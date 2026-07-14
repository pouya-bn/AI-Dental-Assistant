part of '../chat_page.dart';

class _Content extends HookConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final stream = ref.watch(chatProvider);
    useEffect(() {
      ref.read(socketProvider).connect();
      return null;
    }, []);
    return stream.when(
      data: (messages) => _Messages(
        messages: messages,
        scrollController: scrollController,
      ),
      loading: () => const Center(
        child: Loading(),
      ),
      error: (error, _) => const Center(
        child: CustomError(),
      ),
    );
  }
}

class _Messages extends ConsumerStatefulWidget {
  const _Messages({
    required this.messages,
    required this.scrollController,
  });

  final List<AvaMessageModel> messages;
  final ScrollController scrollController;

  @override
  ConsumerState<_Messages> createState() => __MessagesState();
}

class __MessagesState extends ConsumerState<_Messages> {
  late List<AvaMessageModel> _messages;

  @override
  void initState() {
    super.initState();
    _messages = widget.messages;
  }

  @override
  void didUpdateWidget(covariant _Messages oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages.length != widget.messages.length) {
      setState(() {
        _messages = widget.messages;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.scrollController.hasClients) {
          widget.scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.separated(
        controller: widget.scrollController,
        shrinkWrap: true,
        reverse: true,
        itemCount: _messages.length,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _Bubble(
            message: message,
          );
        },
      ),
    );
  }
}
