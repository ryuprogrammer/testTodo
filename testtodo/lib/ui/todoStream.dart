import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// このファイルがエラーになる

class TodoStream extends ConsumerWidget {
  const TodoStream({super.key})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _todoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index]['todo_item']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) {
              return SimpleDialog(
                title: const Text('新規作成プラス'),
                contentPadding: const EdgeInsets.all(10),
                children: [
                  TextFormField(
                    onFieldSubmitted: (value) async {
                      // ここでSupabaseにデータ追加
                      await Supabase.instance.client
                          .from('todos')
                          .insert({'todo_item': value});
                    },
                  ),
                ],
              );
            }),
          );
        },
        child: Text(
          'プラス',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}