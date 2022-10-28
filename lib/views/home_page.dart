import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/injection/injection.dart';
import 'package:riverpod_test/view_models/state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Counter(),
              GreenOrRedList(),
              LoginForm(),
              Expanded(child: TodosList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ref.read(stateProvider.notifier).increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Counter extends ConsumerWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(stateProvider.select((value) => value.counter));

    return Center(
        child: Text(
      viewModel.toString(),
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    ));
  }
}

class TodosList extends ConsumerWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final quotes = ref.watch(
      todosProvider,
    );
    return quotes.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final current = data[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(current.id.toString()),
                  ),
                  title: Text(
                    current.title,
                  ),
                  subtitle: Text(
                    current.completed ? 'completed' : 'in progress',
                  ),
                ),
              );
            },
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator());
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.read(
      stateProvider.notifier,
    );
    ref.listen<ViewModelState>(stateProvider, (prev, state) {
      if (state.loginResult == null) {
        return;
      } else if (state.loginResult is LoginSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Success')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Failure')));
      }
    });
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: 'Username'),
          onChanged: provider.onChangedUserName,
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'Password'),
          onChanged: provider.onChangedPassword,
        ),
        ElevatedButton(
            onPressed: () {
              provider.login();
            },
            child: const Text('Login'))
      ],
    );
  }
}

class GreenOrRedList extends ConsumerWidget {
  const GreenOrRedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex = ref.watch(
      stateProvider.select((value) => value.selectedIndex),
    );

    return SizedBox(
      height: 200,
      child: Builder(builder: (context) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => ref.read(stateProvider.notifier).selectIndex(index),
              child: Container(
                width: 100,
                height: 100,
                color: selectedIndex == index ? Colors.green : Colors.red,
                child: Center(
                  child: Text(index.toString()),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10,
            );
          },
        );
      }),
    );
  }
}
