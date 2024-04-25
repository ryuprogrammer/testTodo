import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final SupabaseClient _supabaseClient;

  NotesController(this._supabaseClient) : super(AsyncLoading());

  // データを追加するメソッド
  Future<void> addNote(String note) async {
    try {
      final response =
          await _supabaseClient.from('todos').insert({'note': note});
      if (response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // データを更新するメソッド
  Future<void> updateNote(int id, String updatedNote) async {
    try {
      final response = await _supabaseClient
          .from('todos')
          .update({'note': updatedNote}).eq('id', id);
      if (response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // データを削除するメソッド
  Future<void> deleteNote(int id) async {
    try {
      final response =
          await _supabaseClient.from('todos').delete().eq('id', id);
      if (response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
