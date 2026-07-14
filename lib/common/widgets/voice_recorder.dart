import 'dart:async';

import 'package:ava/common/values/imports.dart';

class VoiceRecorderWidget extends HookConsumerWidget {
  const VoiceRecorderWidget({
    super.key,
    required this.onAudioSent,
  });

  final VoidCallback onAudioSent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(voiceRecorderProvider).status;
    return SizedBox(
      height: 48.h,
      child: Stack(
        children: [
          if (status == _VoiceRecorderStatus.recording)
            const _RecordingInProgress(),
          if (status == _VoiceRecorderStatus.completed)
            _RecordingCompleted(
              onAudioSent: onAudioSent,
            ),
          if (status != _VoiceRecorderStatus.completed) const _MicButton(),
        ],
      ),
    );
  }
}

class _RecordingInProgress extends HookConsumerWidget {
  const _RecordingInProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchTime = ref.watch(voiceRecorderProvider).stopwatchTime;
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF6D8AF4), Colors.white],
        ),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(
            Icons.circle_rounded,
            size: 20,
            color: Colors.red,
          ),
          const SizedBox(width: 6),
          Text(
            stopwatchTime,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          const Text(
            'Slide to cancel',
            style: TextStyle(
              color: Color(0xFF6A6A6A),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}

class _RecordingCompleted extends HookConsumerWidget {
  const _RecordingCompleted({
    required this.onAudioSent,
  });

  final VoidCallback onAudioSent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceRecorderNotifier = ref.watch(voiceRecorderProvider.notifier);

    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: voiceRecorderNotifier.onVoiceRecordCancelled,
          ),
          IconButton(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          const Spacer(),
          const Text(
            '00:50',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              voiceRecorderNotifier.onVoiceRecordCancelled();
              onAudioSent();
            },
          ),
        ],
      ),
    );
  }
}

class _MicButton extends HookConsumerWidget {
  const _MicButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceRecorderNotifier = ref.watch(voiceRecorderProvider.notifier);

    Future<void> handleCompletion() async {
      voiceRecorderNotifier.stopwatch.stop();
      int timeElapsedInSeconds =
          voiceRecorderNotifier.stopwatch.elapsed.inSeconds;
      if (timeElapsedInSeconds < 1) {
        voiceRecorderNotifier.onVoiceRecordCancelled();
      } else {
        voiceRecorderNotifier.onVoiceRecordCompleted();
      }
    }

    return GestureDetector(
      onTapDown: (_) {
        voiceRecorderNotifier.stopwatch.start();
        voiceRecorderNotifier.onVoiceRecordStarted();
      },
      onTapUp: (_) async {
        await handleCompletion();
      },
      child: Tooltip(
        message: 'Hold to record audio',
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Material(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.mic,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final voiceRecorderProvider =
    StateNotifierProvider<VoiceRecorderNotifier, _VoiceRecorderState>(
  (ref) => VoiceRecorderNotifier(),
);

class VoiceRecorderNotifier extends StateNotifier<_VoiceRecorderState> {
  VoiceRecorderNotifier()
      : super(_VoiceRecorderState(
          micValueNotifier: ValueNotifier(1.0),
        )) {
    stopwatch = Stopwatch();
  }

  late Stopwatch stopwatch;

  void onVoiceRecordStarted() {
    stopwatch.start();
    _updateStopwatchTime();
    state = state.copyWith(
      status: _VoiceRecorderStatus.recording,
    );
  }

  void onVoiceRecordCompleted() {
    state.micValueNotifier.value = 1.0;
    stopwatch.reset();
    state = state.copyWith(
      status: _VoiceRecorderStatus.completed,
      stopwatchTime: '00:00:00',
    );
  }

  void onVoiceRecordCancelled() {
    state.micValueNotifier.value = 1.0;
    stopwatch.reset();
    state = state.copyWith(
      status: _VoiceRecorderStatus.inactive,
      stopwatchTime: '00:00:00',
    );
  }

  void _updateStopwatchTime() {
    Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (stopwatch.isRunning) {
          final elapsed = stopwatch.elapsed;

          final int hundreds = (elapsed.inMilliseconds / 10).truncate();
          final int seconds = (hundreds / 100).truncate();
          final int minutes = (seconds / 60).truncate();

          String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
          String minutesStr = (minutes % 60).toString().padLeft(2, '0');
          String secondsStr = (seconds % 60).toString().padLeft(2, '0');

          state = state.copyWith(
            stopwatchTime: '$minutesStr:$secondsStr:$hundredsStr',
          );
        } else {
          timer.cancel();
        }
      },
    );
  }
}

enum _VoiceRecorderStatus {
  inactive,
  recording,
  completed,
}

class _VoiceRecorderState {
  _VoiceRecorderState({
    this.status = _VoiceRecorderStatus.inactive,
    this.stopwatchTime = '00:00:00',
    required this.micValueNotifier,
  });

  final _VoiceRecorderStatus status;
  final String stopwatchTime;
  final ValueNotifier<double> micValueNotifier;

  _VoiceRecorderState copyWith({
    _VoiceRecorderStatus? status,
    String? stopwatchTime,
    ValueNotifier<double>? micValueNotifier,
  }) {
    return _VoiceRecorderState(
      status: status ?? this.status,
      stopwatchTime: stopwatchTime ?? this.stopwatchTime,
      micValueNotifier: micValueNotifier ?? this.micValueNotifier,
    );
  }
}
