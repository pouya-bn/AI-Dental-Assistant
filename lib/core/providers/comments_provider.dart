import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_provider.g.dart';

@riverpod
class Comments extends _$Comments {
  @override
  CommentsState build() => CommentsState();

  void setReplying(bool value) {
    state = state.copyWith(isReplying: value);
  }
}

class CommentsState {
  final bool isReplying;

  CommentsState({
    this.isReplying = false,
  });

  CommentsState copyWith({
    bool? isReplying,
  }) {
    return CommentsState(
      isReplying: isReplying ?? this.isReplying,
    );
  }
}
