import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/connectivity_controller.dart';

class SyncManager {
  static final SyncManager instance = SyncManager._();
  SyncManager._();

  static const String _queueKey = 'pending_writes_queue';

  Future<void> addToQueue(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = prefs.getStringList(_queueKey) ?? [];
    queue.add(jsonEncode(data));
    await prefs.setStringList(_queueKey, queue);
  }

  Future<void> sync() async {
    if (!ConnectivityController.instance.isConnected.value) return;

    final prefs = await SharedPreferences.getInstance();
    final queue = prefs.getStringList(_queueKey) ?? [];
    if (queue.isEmpty) return;

    // TODO: Implement actual Firestore write logic here
    print('Syncing ${queue.length} items...');
    
    // For now, clear the queue as if it succeeded
    await prefs.remove(_queueKey);
  }
}
