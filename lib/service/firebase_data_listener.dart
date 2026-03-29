import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:get/get.dart';

enum FirebaseDataListenerError {
  none,
  notFound,
  custom
}

class FirebaseDataListener extends GetxService {
  // Reactive variables
  // final Rx<DocumentSnapshot?> _snapshot = Rx<DocumentSnapshot?>(null);
  // final RxBool isLoading = true.obs;
  // final RxString errorMessage = ''.obs;

  StreamSubscription<DocumentSnapshot>? _subscription;

  final String collectionId;
  final Function(String, Map<String, dynamic>) onRetrieveData;
  final Function(FirebaseDataListenerError, String) onError;
  FirebaseDataListener({required this.collectionId, required this.onRetrieveData, required this.onError});

  // Call this when entering the room screen
  listenToDocument(String documentId) {
    // Cancel previous if exists (switching rooms)
    _subscription?.cancel();

    _subscription = FirebaseFirestore.instance
      .collection(collectionId)
      .doc(documentId)
      .snapshots()
      .listen((snapshot) {
        final data = snapshot.data();
        if (snapshot.exists && data != null) {
          onRetrieveData(snapshot.id, data);
        } else {
          onError(FirebaseDataListenerError.notFound, "Data not found");
        }
      },
      onError: (error) {
        debugLog('Firebase data stream error: $error');
        onError(FirebaseDataListenerError.custom, error.toString());
      },
    );
  }

  stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  // Clean up when leaving the app or switching rooms
  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  // Convenience getters (optional)
  // Map<String, dynamic>? get roomData => snapshot.value?.data() as Map<String, dynamic>?;
  //
  // String get status => roomData?['status'] ?? 'unknown';
  // int get currentRound => roomData?['currentRound'] ?? 0;
  // String get roundPhase => roomData?['roundPhase'] ?? 'unknown';
  // List<dynamic> get players => roomData?['players'] ?? [];
  // List<dynamic> get survivors => roomData?['survivors'] ?? [];
}