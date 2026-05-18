import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../data/models/staff_model.dart';
import '../cubit/staff_cubit.dart';
import '../refactor/staff_constants.dart';

class StaffFormBottomSheet extends StatefulWidget {
  const StaffFormBottomSheet({required this.branches, this.staff, super.key});
  final StaffModel? staff;
  final List<BranchModel> branches;
  @override
  State<StaffFormBottomSheet> createState() => _StaffFormBottomSheetState();
}

class _StaffFormBottomSheetState extends State<StaffFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name, _email, _phone, _license, _hireDate;
  late String _role;
  String? _branchId;
  late bool _active;
  bool get _isEditing => widget.staff != null;

  @override
  void initState() {
    super.initState();
    final s = widget.staff;
    _name = TextEditingController(text: s?.fullName ?? '');
    _email = TextEditingController(text: s?.email ?? '');
    _phone = TextEditingController(text: s?.phone ?? '');
    _license = TextEditingController(text: s?.licenseNumber ?? '');
    _hireDate = TextEditingController(text: s?.hireDate ?? '');
    _role = s?.role ?? 'technician';
    _branchId = s?.branchId;
    _active = s?.isActive ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _license.dispose();
    _hireDate.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    BranchModel? branch;
    for (final item in widget.branches) {
      if (item.id == _branchId) {
        branch = item;
        break;
      }
    }
    final staff = StaffModel(
      id: widget.staff?.id ?? '',
      fullName: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      role: _role,
      branchId: _branchId ?? '',
      branchName: branch?.name,
      licenseNumber: _license.text.trim(),
      hireDate: _hireDate.text.trim(),
      isActive: _active,
    );
    if (_isEditing) {
      await context.read<StaffCubit>().updateStaff(staff);
    } else {
      await context.read<StaffCubit>().createStaff(staff);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottom + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 18.h),
                TextApp(
                  text: _isEditing ? 'Edit Staff' : 'Add Staff Member',
                  theme: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Full Name *'),
                  validator: _required,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email *'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _required,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(labelText: 'Role *'),
                  items: staffRoles
                      .map(
                        (r) => DropdownMenuItem(
                          value: r,
                          child: Text(formatStaffRole(r)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _role = v ?? _role),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: _branchId,
                  decoration: const InputDecoration(labelText: 'Branch *'),
                  items: widget.branches
                      .map(
                        (b) =>
                            DropdownMenuItem(value: b.id, child: Text(b.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _branchId = v),
                  validator: _required,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _license,
                  decoration: const InputDecoration(labelText: 'License #'),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _hireDate,
                  decoration: const InputDecoration(
                    labelText: 'Hire Date',
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
                SwitchListTile(
                  value: _active,
                  onChanged: (v) => setState(() => _active = v),
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
                AppPrimaryButton(text: 'Save Staff', onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;
}
