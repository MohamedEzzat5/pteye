import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pteye/Features/home/presentation/manger/files_cubit/files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(FilesInitial());
  Future<String?> fetchUserId() async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc().get();
      return userDoc.id;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user ID: $e');
      }
      return null;
    }
  }
  void fetchSelectedItems(String userId) async {
    emit(FilesLoading());
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc().get();
      final data = userSnapshot.data();
      if (data != null && data.containsKey('selectedItems')) {
        final List<Map<String, dynamic>> selectedItems =
        List<Map<String, dynamic>>.from(data['selectedItems']);
        emit(FilesLoaded(selectedItems: selectedItems));
      } else {
        emit(FilesLoaded(selectedItems: const []));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching selected items: $e');
      }
      emit(FilesError(error: 'Error fetching selected items: $e'));
    }
  }
}
