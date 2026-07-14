part of '../forum_halls_page.dart';

class _Media extends StatelessWidget {
  const _Media();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: CustomMediaGrid(
        fallback: 'assets/images/clinic.png',
      ),
    );
  }
}
