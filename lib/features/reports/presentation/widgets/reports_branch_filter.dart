import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../branches/data/models/branch_model.dart';

class ReportsBranchFilter extends StatelessWidget {
  const ReportsBranchFilter({
    required this.branches,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final List<BranchModel> branches;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: context.translate(LangKeys.branch),
        ),
        items: [
          DropdownMenuItem<String>(
            value: 'all',
            child: TextApp(
              text: context.translate(LangKeys.allBranches),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
          ...branches.map((branch) {
            return DropdownMenuItem<String>(
              value: branch.id,
              child: TextApp(
                text: branch.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            );
          }),
        ],
        onChanged: (value) {
          if (value == null) return;
          onChanged(value);
        },
      ),
    );
  }
}
