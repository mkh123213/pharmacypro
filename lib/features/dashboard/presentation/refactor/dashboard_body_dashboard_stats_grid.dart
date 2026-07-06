part of 'dashboard_body.dart';

class _DashboardStatsGrid extends StatelessWidget {
  const _DashboardStatsGrid({required this.summary});

  final DashboardSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final cards = buildDashboardSummaryCards(summary, context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1200
            ? 4
            : constraints.maxWidth >= 800
            ? 3
            : constraints.maxWidth >= 520
            ? 2
            : 1;

        return GridView.builder(
          itemCount: cards.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: count == 1 ? 3.15 : 2.1,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            final route = card.route;

            return DashboardStatCard(
              title: context.translate(card.titleKey),
              value: card.value,
              subtitle: context.translate(card.subtitleKey),

              imagePath: card.imagePath,
              onTap: route == null
                  ? null
                  : () {
                      context.push(route);
                    },
            );
          },
        );
      },
    );
  }
}
