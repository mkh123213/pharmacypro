import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

class SaleSummaryCard extends StatelessWidget {
  const SaleSummaryCard({
    required this.subtotal,
    required this.discount,
    required this.total,
    super.key,
  });

  final double subtotal;
  final double discount;
  final double total;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            _SummaryRow(
              label: context.translate(LangKeys.subtotal),
              value: '\$${subtotal.toStringAsFixed(2)}',
            ),
            SizedBox(height: 6.h),
            _SummaryRow(
              label: context.translate(LangKeys.discount),
              value: '\$${discount.toStringAsFixed(2)}',
            ),
            Divider(height: 20.h),
            _SummaryRow(
              label: context.translate(LangKeys.total),
              value: '\$${total.toStringAsFixed(2)}',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = context.textStyle.copyWith(
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );

    return Row(
      children: [
        Expanded(
          child: TextApp(
            text: label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: style,
          ),
        ),
        SizedBox(width: 12.w),
        TextApp(
          text: value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          theme: style,
        ),
      ],
    );
  }
}
