import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pteye/Features/home/presentation/manger/files_cubit/files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(FilesInitial());

  void fetchSelectedItems() async {
    emit(FilesInitial());
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('selected_items')
          .where(FieldPath.documentId, isEqualTo: currentUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Document with ID equal to currentUserId found
        Map<String, dynamic> selectedItems = querySnapshot.docs.first.data();
        List<Map<String, dynamic>> videos =
        List<Map<String, dynamic>>.from(selectedItems['selectedItems']);
        emit(FilesLoaded(selectedItems: videos));
      }else if(querySnapshot.docs.isEmpty){
        emit(FilesNoData());
      }

      else {
        // Document with ID equal to currentUserId not found
        emit(FilesLoaded(selectedItems: const []));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching exercise videos: $e');
      }
      emit(FilesError(error: 'لا يوجد ملفات حاليًا'));
    }
  }

  Future<void> markItemAsDone() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('selected_items')
          .doc(currentUserId)
          .update({'isDone': true});

      // Emit a state to indicate the item has been marked as done
      emit(ItemMarkedAsDone());
    } catch (e) {
      // Emit an error state if the update fails
      emit(FilesError(error: 'Failed to mark item as done!'));
    }
  }
}

