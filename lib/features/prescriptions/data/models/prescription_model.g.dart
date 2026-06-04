// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    PrescriptionModel(
      id: json['id'] as String,
      patientName: json['patient_name'] as String,
      branchId: json['branch_id'] as String,
      prescriptionNumber: json['prescription_number'] as String?,
      patientPhone: json['patient_phone'] as String?,
      patientDob: json['patient_dob'] as String?,
      doctorName: json['doctor_name'] as String?,
      doctorLicense: json['doctor_license'] as String?,
      issueDate: json['issue_date'] as String?,
      expiryDate: json['expiry_date'] as String?,
      branchName: json['branch_name'] as String?,
      status: json['status'] as String? ?? 'pending',
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      imageUrl: json['image_url'] as String?,
      notes: json['notes'] as String?,
      createdAt: dateTimeFromJson(json['created_at']),
      updatedAt: dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$PrescriptionModelToJson(PrescriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prescription_number': instance.prescriptionNumber,
      'patient_name': instance.patientName,
      'patient_phone': instance.patientPhone,
      'patient_dob': instance.patientDob,
      'doctor_name': instance.doctorName,
      'doctor_license': instance.doctorLicense,
      'issue_date': instance.issueDate,
      'expiry_date': instance.expiryDate,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'status': instance.status,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'image_url': instance.imageUrl,
      'notes': instance.notes,
      'created_at': dateTimeToJson(instance.createdAt),
      'updated_at': dateTimeToJson(instance.updatedAt),
    };
