import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final SupabaseClient _supabaseClient;

  TodoController(this._supabaseClient) : super(AsyncLoading());

  // データを追加するメソッド
  Future<void> addTodo(String todo) async {
    try {
      final response =
          await _supabaseClient.from('todos').insert({'todo_item': todo});
      if (response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // データを更新するメソッド
  Future<void> updateTodo(int id, String updateTodo) async {
    try {
      final response = await _supabaseClient
          .from('todos')
          .update({'todo_item': updateTodo}).eq('id', id);
      if (response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // データを削除するメソッド
  Future<void> deleteTodo(int id) async {
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
