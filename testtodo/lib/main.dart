import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lleeoganlvrrnhhjmjgl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxsZWVvZ2FubHZycm5oaGptamdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM4OTIzMzUsImV4cCI6MjAyOTQ2ODMzNX0.dVMFBgpLJ7YNgrMZEOqaGu06vOOpfYR-OEcpWdlbFr8',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todoStream =
      Supabase.instance.client.from('todos').stream(primaryKey: ['id']);

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
                title: const Text('新規作成'),
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
          '新規作成',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
