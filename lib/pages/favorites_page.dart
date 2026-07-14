import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';

class FavoritesPage extends HookConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      titleText: 'علاقه مندی‌ها',
      background: const Background2(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
        ),
        children: [
          CustomLabel(
            label: const LabelModel(
              icon: 'assets/images/svg/heart-tick.svg',
              title: 'درمان‌ها',
            ),
            margin: 20.w,
            onShowAll: () {},
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _items1.length,
              separatorBuilder: (_, __) {
                return SizedBox(width: 10.w);
              },
              itemBuilder: (context, index) {
                return _Item(
                  model: _items1[index % _items1.length],
                );
              },
            ),
          ),
          CustomDivider(
            height: 40.h,
            color: AppColors.white20,
            margin: 20.w,
          ),
          CustomLabel(
            label: const LabelModel(
              icon: 'assets/images/svg/hearts.svg',
              title: 'گفتگو‌ها',
            ),
            margin: 20.w,
            onShowAll: () {},
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _items2.length,
              separatorBuilder: (_, __) {
                return SizedBox(width: 10.w);
              },
              itemBuilder: (context, index) {
                return _Item(
                  model: _items2[index % _items2.length],
                );
              },
            ),
          ),
          CustomDivider(
            height: 40.h,
            color: AppColors.white20,
            margin: 20.w,
          ),
          CustomLabel(
            label: const LabelModel(
              icon: 'assets/images/svg/heart-tick.svg',
              title: 'دندانپزشک‌‌ها',
            ),
            margin: 20.w,
            onShowAll: () {},
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 185.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _doctors.length,
              separatorBuilder: (_, __) {
                return SizedBox(width: 10.w);
              },
              itemBuilder: (context, index) {
                return _DoctorItem(
                  model: _doctors[index % _doctors.length],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final _items1 = [
  _ItemModel(
    title: 'لمینت سرامیکی',
    image: 'assets/images/temp/fav1.png',
  ),
  _ItemModel(
    title: 'کامپوزیت ونیر',
    image: 'assets/images/temp/fav2.png',
  ),
  _ItemModel(
    title: 'ایمپلنت',
    image: 'assets/images/temp/fav3.png',
  ),
];

final _items2 = [
  _ItemModel(
    title: 'دندانپزشکی دیجیتال',
    image: 'assets/images/temp/fav4.png',
  ),
  _ItemModel(
    title: 'درمان‌های زیبایی',
    image: 'assets/images/temp/fav5.png',
  ),
  _ItemModel(
    title: 'لابراتور دیجیتال',
    image: 'assets/images/temp/fav6.png',
  ),
];

final _doctors = [
  _DoctorItemModel(
    name: 'دکتر رضا ملا',
    specialty: 'پریودنتیست  |  کلینیک راد',
    image: 'assets/images/temp/doctor.png',
  ),
  _DoctorItemModel(
    name: 'دکتر علی حسینی',
    specialty: 'دندانپزشک  |  کلینیک راد',
    image: 'assets/images/temp/find_2.png',
  ),
  _DoctorItemModel(
    name: 'دکتر فاطمه کاشفی',
    specialty: 'دندانپزشک  |  کلینیک راد',
    image: 'assets/images/temp/find_3.png',
  ),
];

class _Item extends StatelessWidget {
  const _Item({
    required this.model,
  });

  final _ItemModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 107.h,
          width: 148.w,
          decoration: ShapeDecoration(
            color: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(
                color: AppColors.blue12,
                width: 1.w,
              ),
            ),
            image: DecorationImage(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          model.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelSmall.copyWith(
            color: AppColors.onSecondary,
          ),
        ),
      ],
    );
  }
}

class _ItemModel {
  final String title;
  final String image;

  _ItemModel({
    required this.title,
    required this.image,
  });
}

class _DoctorItem extends StatelessWidget {
  const _DoctorItem({
    required this.model,
  });

  final _DoctorItemModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.doctor);
      },
      child: Container(
        height: 185.h,
        width: 148.w,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(
              color: AppColors.blue12,
              width: 1.w,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 107.h,
              width: 148.w,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9.r),
                  topRight: Radius.circular(9.r),
                ),
                child: Image.asset(
                  model.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall.copyWith(
                      color: AppColors.onSecondary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    model.specialty,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelSmall.copyWith(
                      color: AppColors.tertiary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorItemModel {
  final String name;
  final String specialty;
  final String image;

  _DoctorItemModel({
    required this.name,
    required this.specialty,
    required this.image,
  });
}
