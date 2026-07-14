import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/core/providers/about_provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends HookConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref.watch(aboutProvider);
    return CustomScaffold.variant(
      titleText: 'درباره اپلیکیشن',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: about.when(
        data: (about) {
          return ListView(
            primary: false,
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
            ),
            children: [
              _InfoTile(
                title: 'درباره اپلیکیشن آوا',
                description: about.aboutUs,
                isExpanded: true,
              ),
              CustomDivider(
                height: 20.h,
                color: AppColors.blue11,
              ),
              _InfoTile(
                title: 'قوانین و مقررات',
                description: about.rule,
                isExpanded: false,
              ),
              CustomDivider(
                height: 20.h,
                color: AppColors.blue11,
              ),
              _InfoTile(
                title: 'حریم خصوصی',
                description: about.privacy,
                isExpanded: false,
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Loading(),
        ),
        error: (error, _) => const Center(
          child: CustomError(),
        ),
      ),
    );
  }
}

class _InfoTile extends HookWidget {
  const _InfoTile({
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  final String title;
  final String? description;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(this.isExpanded);
    return Theme(
      data: context.theme.copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ExpansionTile(
        dense: true,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: isExpanded.value,
        onExpansionChanged: (value) {
          isExpanded.value = value;
        },
        iconColor: AppColors.blue7,
        collapsedIconColor: AppColors.blue7,
        expandedAlignment: Alignment.centerRight,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelMedium.copyWith(
            color: AppColors.blue7,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            child: HtmlWidget(
              description ?? 'اطلاعاتی وجود ندارد',
              onTapUrl: (url) async {
                try {
                  final uri = Uri.parse(url);
                  return await launchUrl(uri);
                } catch (e) {
                  AppToast.showError(
                    title: 'خطا در باز کردن لینک',
                    description: 'لطفا دوباره تلاش کنید',
                  );
                  return false;
                }
              },
              textStyle: context.labelSmall.copyWith(
                color: AppColors.secondary,
              ),
              customStylesBuilder: (element) {
                if (element.classes.contains('link')) {
                  return {
                    'text-decoration': 'underline',
                    'color': '#0065FF',
                  };
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
