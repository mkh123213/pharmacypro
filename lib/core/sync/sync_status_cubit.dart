import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum SyncStatus { synced, syncing, pending }

class SyncStatusState extends Equatable {
  final SyncStatus status;
  final int pendingCount;

  const SyncStatusState({required this.status, required this.pendingCount});

  @override
  List<Object> get props => [status, pendingCount];
}

class SyncStatusCubit extends Cubit<SyncStatusState> {
  SyncStatusCubit() : super(const SyncStatusState(status: SyncStatus.synced, pendingCount: 0));

  void updateStatus(SyncStatus status, int pendingCount) {
    emit(SyncStatusState(status: status, pendingCount: pendingCount));
  }
}
