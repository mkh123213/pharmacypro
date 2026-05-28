import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'prescription_item_model.dart';

part 'prescription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrescriptionModel {
  const PrescriptionModel({
    required this.id,
    required this.patientName,
    required this.branchId,
    this.prescriptionNumber,
    this.patientPhone,
    this.patientDob,
    this.doctorName,
    this.doctorLicense,
    this.issueDate,
    this.expiryDate,
    this.branchName,
    this.status = 'pending',
    this.items = const [],
    this.imageUrl,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  @JsonKey(name: 'prescription_number')
  final String? prescriptionNumber;

  @JsonKey(name: 'patient_name')
  final String patientName;

  @JsonKey(name: 'patient_phone')
  final String? patientPhone;

  @JsonKey(name: 'patient_dob')
  final String? patientDob;

  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  @JsonKey(name: 'doctor_license')
  final String? doctorLicense;

  @JsonKey(name: 'issue_date')
  final String? issueDate;

  @JsonKey(name: 'expiry_date')
  final String? expiryDate;

  @JsonKey(name: 'branch_id')
  final String branchId;

  @JsonKey(name: 'branch_name')
  final String? branchName;

  final String status;
  final List<PrescriptionItemModel> items;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  final String? notes;

  @JsonKey(name: 'created_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime? updatedAt;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) => _$PrescriptionModelFromJson(json);

  factory PrescriptionModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    return PrescriptionModel.fromJson({...data, 'id': document.id});
  }

  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson()
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    return json;
  }

  PrescriptionModel copyWith({
    String? status,
  }) {
    return PrescriptionModel(
      id: id,
      prescriptionNumber: prescriptionNumber,
      patientName: patientName,
      patientPhone: patientPhone,
      patientDob: patientDob,
      doctorName: doctorName,
      doctorLicense: doctorLicense,
      issueDate: issueDate,
      expiryDate: expiryDate,
      branchId: branchId,
      branchName: branchName,
      status: status ?? this.status,
      items: items,
      imageUrl: imageUrl,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}

DateTime? dateTimeFromJson(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

Object? dateTimeToJson(DateTime? value) {
  if (value == null) return null;
  return Timestamp.fromDate(value);
}
