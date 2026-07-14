part of '../statistics_page.dart';

class _Views extends HookWidget {
  const _Views();

  static const _filters = [
    'هفتگی',
    'ماهانه',
    '3 ماهه',
    'سالانه',
  ];

  @override
  Widget build(BuildContext context) {
    final selected = useState('هفتگی');
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 15.h, 15.w, 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primary,
          width: 1.w,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'بازدید پروفایل شما',
                  style: context.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              for (final filter in _filters)
                _Filter(
                  title: filter,
                  isSelected: selected.value == filter,
                  onTap: () {
                    selected.value = filter;
                  },
                ),
            ],
          ),
          SizedBox(height: 30.h),
          const _ViewsChart(),
        ],
      ),
    );
  }
}

class _ViewsChart extends StatelessWidget {
  const _ViewsChart();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 7,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              isStrokeCapRound: true,
              barWidth: 7,
              color: AppColors.pink,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: const [
                FlSpot(2, 2),
                FlSpot(5, 3.8),
                FlSpot(8, 2.2),
                FlSpot(10, 4.8),
                FlSpot(11, 4.3),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 40,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    (value.toInt() * 100).toString(),
                    textAlign: TextAlign.center,
                    style: context.bodySmall.copyWith(
                      color: AppColors.blue20,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 60,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 25,
                    angle: -(math.pi / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          switch (value.toInt()) {
                            1 => 'فروردین',
                            2 => 'اردیبهشت',
                            3 => 'خرداد',
                            4 => 'تیر',
                            5 => 'مرداد',
                            6 => 'شهریور',
                            7 => 'مهر',
                            8 => 'آبان',
                            9 => 'آذر',
                            10 => 'دی',
                            11 => 'بهمن',
                            12 => 'اسفند',
                            _ => '-',
                          },
                          style: context.bodySmall.copyWith(
                            color: AppColors.blue20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
