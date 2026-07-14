import 'dart:math' as math;

import 'package:ava/common/values/imports.dart';
import 'package:fl_chart/fl_chart.dart';

part 'widgets/consult.dart';
part 'widgets/filter.dart';
part 'widgets/views.dart';

class StatisticsPage extends HookConsumerWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      titleText: 'گزارشات',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: ListView(
        primary: false,
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
        ),
        children: [
          const _Consult(),
          SizedBox(height: 10.h),
          const _Views(),
        ],
      ),
    );
  }
}
