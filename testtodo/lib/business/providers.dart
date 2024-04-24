import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// プロバイダー: Supabaseをインスタンス化
final todoProvider = StateProvider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// プロバイダー: Supabaseからリアルタイムにデータを取得
final todoStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return Supabase.instance.client.from('todos').stream(primaryKey: ['id']);
});

// プロバイダー: TextEditorController用
final bodyProvider = StateProvider.autoDispose((ref) {
  // riverpodで使用するために、('')を使用
  return TextEditingController(text: '');
});
