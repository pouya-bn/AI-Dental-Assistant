import 'package:ava/common/values/imports.dart';
import 'package:time_range_picker/time_range_picker.dart';

Future<TimeRange?> showCustomTimeRangePicker(
  BuildContext context, {
  TimeOfDay? initialStartTime,
  TimeOfDay? initialEndTime,
  Duration? maxDuration,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  var startTime = const TimeOfDay(hour: 9, minute: 0);
  var endTime = const TimeOfDay(hour: 17, minute: 0);
  final result = await showTimeRangePicker(
    context: context,
    start: initialStartTime ?? startTime,
    end: initialEndTime ?? endTime,
    onStartChange: (start) => startTime = start,
    onEndChange: (end) => endTime = end,
    interval: const Duration(minutes: 15),
    minDuration: const Duration(minutes: 15),
    maxDuration: maxDuration,
    use24HourFormat: true,
    ticks: 24,
    ticksColor: Colors.white,
    paintingStyle: PaintingStyle.stroke,
    backgroundColor: AppColors.blue11,
    fromText: 'از ساعت',
    toText: 'تا ساعت',
    snap: true,
    labelOffset: -30,
    labelStyle: context.bodySmall.copyWith(
      color: AppColors.blue12,
    ),
    labels: [
      "00",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
    ].asMap().entries.map((e) {
      return ClockLabel.fromIndex(
        idx: e.key,
        text: e.value,
        length: 24,
      );
    }).toList(),
  );
  if (result != null) {
    final timeRange = TimeRange(
      startTime: startTime,
      endTime: endTime,
    );
    logger(timeRange.toString());
    return timeRange;
  }
  return null;
}
