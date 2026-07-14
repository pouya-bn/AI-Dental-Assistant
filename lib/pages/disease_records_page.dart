import 'package:ava/common/values/imports.dart';

class DiseaseRecordsPage extends HookConsumerWidget {
  const DiseaseRecordsPage({super.key});

  static const _records = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold.variant(
      titleText: 'سوابق بیماری',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: _records.isEmpty
          ? const CustomEmpty()
          : ListView.separated(
              itemCount: _records.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (_, index) => const _Tile(),
            ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
