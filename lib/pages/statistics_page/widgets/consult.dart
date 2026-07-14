part of '../statistics_page.dart';

class _Consult extends HookWidget {
  const _Consult();

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
                  'تعداد مشاوره ها',
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
          SizedBox(height: 10.h),
          const _ConsultChart(),
        ],
      ),
    );
  }
}

class _ConsultChart extends StatelessWidget {
  const _ConsultChart();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _Indicator(
                color: AppColors.primary,
                text: 'تلفنی',
              ),
              SizedBox(height: 4.h),
              const _Indicator(
                color: AppColors.tertiary,
                text: 'متنی',
              ),
            ],
          ),
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: [
                    PieChartSectionData(
                      color: AppColors.primary,
                      value: 40,
                      title: '40%',
                      radius: 40,
                      titleStyle: context.labelMedium.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                    PieChartSectionData(
                      color: AppColors.tertiary,
                      value: 30,
                      title: '30%',
                      radius: 40,
                      titleStyle: context.labelMedium.copyWith(
                        color: AppColors.onTertiary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 8.h,
          width: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: context.bodySmall.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
