class StockTransferModel {
  final String id;
  final String transferNumber;
  final String sourceBranchId;
  final String sourceBranchName;
  final String destinationBranchId;
  final String destinationBranchName;
  final List<Map<String, dynamic>> items;
  final String status;
  final String requestedBy;
  final String? approvedBy;
  final String? shippedBy;
  final String? receivedBy;
  final String notes;
  final DateTime requestedAt;
  final DateTime? shippedAt;
  final DateTime? receivedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  StockTransferModel({
    required this.id,
    required this.transferNumber,
    required this.sourceBranchId,
    required this.sourceBranchName,
    required this.destinationBranchId,
    required this.destinationBranchName,
    required this.items,
    required this.status,
    required this.requestedBy,
    this.approvedBy,
    this.shippedBy,
    this.receivedBy,
    required this.notes,
    required this.requestedAt,
    this.shippedAt,
    this.receivedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockTransferModel.fromJson(Map<String, dynamic> json) {
    return StockTransferModel(
      id: json['id'],
      transferNumber: json['transferNumber'],
      sourceBranchId: json['sourceBranchId'],
      sourceBranchName: json['sourceBranchName'],
      destinationBranchId: json['destinationBranchId'],
      destinationBranchName: json['destinationBranchName'],
      items: List<Map<String, dynamic>>.from(json['items']),
      status: json['status'],
      requestedBy: json['requestedBy'],
      approvedBy: json['approvedBy'],
      shippedBy: json['shippedBy'],
      receivedBy: json['receivedBy'],
      notes: json['notes'],
      requestedAt: DateTime.parse(json['requestedAt']),
      shippedAt: json['shippedAt'] != null ? DateTime.parse(json['shippedAt']) : null,
      receivedAt: json['receivedAt'] != null ? DateTime.parse(json['receivedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transferNumber': transferNumber,
      'sourceBranchId': sourceBranchId,
      'sourceBranchName': sourceBranchName,
      'destinationBranchId': destinationBranchId,
      'destinationBranchName': destinationBranchName,
      'items': items,
      'status': status,
      'requestedBy': requestedBy,
      'approvedBy': approvedBy,
      'shippedBy': shippedBy,
      'receivedBy': receivedBy,
      'notes': notes,
      'requestedAt': requestedAt.toIso8601String(),
      'shippedAt': shippedAt?.toIso8601String(),
      'receivedAt': receivedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
