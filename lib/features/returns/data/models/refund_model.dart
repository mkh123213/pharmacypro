class RefundModel {
  final String id;
  final String refundNumber;
  final String originalSaleId;
  final String originalSaleNumber;
  final String branchId;
  final String branchName;
  final String customerName;
  final List<Map<String, dynamic>> items;
  final double totalRefundAmount;
  final String reason;
  final String reasonDetails;
  final String processedBy;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  RefundModel({
    required this.id,
    required this.refundNumber,
    required this.originalSaleId,
    required this.originalSaleNumber,
    required this.branchId,
    required this.branchName,
    required this.customerName,
    required this.items,
    required this.totalRefundAmount,
    required this.reason,
    required this.reasonDetails,
    required this.processedBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RefundModel.fromJson(Map<String, dynamic> json) {
    return RefundModel(
      id: json['id'],
      refundNumber: json['refundNumber'],
      originalSaleId: json['originalSaleId'],
      originalSaleNumber: json['originalSaleNumber'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      customerName: json['customerName'],
      items: List<Map<String, dynamic>>.from(json['items']),
      totalRefundAmount: json['totalRefundAmount'].toDouble(),
      reason: json['reason'],
      reasonDetails: json['reasonDetails'],
      processedBy: json['processedBy'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'refundNumber': refundNumber,
      'originalSaleId': originalSaleId,
      'originalSaleNumber': originalSaleNumber,
      'branchId': branchId,
      'branchName': branchName,
      'customerName': customerName,
      'items': items,
      'totalRefundAmount': totalRefundAmount,
      'reason': reason,
      'reasonDetails': reasonDetails,
      'processedBy': processedBy,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
