import 'package:ava/common/values/imports.dart';
import 'package:ava/common/widgets/divider.dart';
import 'package:ava/common/widgets/search_field.dart';
import 'package:ava/core/providers/faq_provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqPage extends HookConsumerWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqs = ref.watch(faqProvider);
    final controller = useTextEditingController();
    useDebouncedSearch(
      controller,
      onDebounce: (value) {
        if (value.isEmpty) {
          ref.read(faqProvider.notifier).getAllFaqs();
        } else {
          ref.read(faqProvider.notifier).searchFaqs(value);
        }
      },
    );
    return CustomScaffold.variant(
      titleText: 'سوالات متداول',
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          SearchField(
            controller: controller,
            onClear: controller.clear,
          ),
          Expanded(
            child: faqs.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: CustomEmpty(),
                  );
                }
                return ListView.separated(
                  primary: false,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  separatorBuilder: (context, index) => CustomDivider(
                    height: 20.h,
                    color: AppColors.blue11,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final faq = data[index];
                    return _FaqTile(
                      question: faq.question,
                      answer: faq.answer,
                      isExpanded: index == 0,
                    );
                  },
                );
              },
              loading: () => const Center(
                child: Loading(),
              ),
              error: (error, _) => const Center(
                child: CustomError(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends HookWidget {
  const _FaqTile({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  final String question;
  final String answer;
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
          question,
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
              answer,
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
            ),
          ),
        ],
      ),
    );
  }
}
