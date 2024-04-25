import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AsyncNotifierを使用するためにAsyncNotifierProviderを定義
final todoController =
    AsyncNotifierProvider<TodoController, void>(TodoController.new);

final todoStream = Supabase.instance.client;

// Supabaseを操作するAsyncNotifier
class TodoController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  // データを追加するメソッド
  Future<void> addNotes(String _body) async {
    final appRepository = ref.read(todoController);
    await appRepository.from('notes').insert({'note_item': _body});
  }

  // データを更新するメソッド
  Future<void> updateNotes(dynamic noteID, String _body) async {
    final appRepository = ref.read(todoController);
    await appRepository
        .from('notes')
        .update({'note_item': _body}).match({'id': noteID});
  }

  // データを削除するメソッド
  Future<void> deleteNotes(dynamic noteID) async {
    final appRepository = ref.read(todoController);
    await appRepository.from('notes').delete().match({'id': noteID});
  }
}
