// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) => ShiftModel(
  id: json['id'] as String,
  staffId: json['staff_id'] as String,
  branchId: json['branch_id'] as String,
  date: json['date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  staffName: json['staff_name'] as String?,
  branchName: json['branch_name'] as String?,
  status: json['status'] as String? ?? 'scheduled',
  notes: json['notes'] as String?,
  createdAt: dateTimeFromJson(json['created_at']),
  updatedAt: dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$ShiftModelToJson(ShiftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'status': instance.status,
      'notes': instance.notes,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
