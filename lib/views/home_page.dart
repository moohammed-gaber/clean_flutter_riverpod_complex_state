import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/injection/injection.dart';
import 'package:riverpod_test/view_models/state.dart';
import 'package:riverpod_test/view_models/view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Counter(),
                GreenOrRedList(),
                LoginForm(),
                QuotesList(),
                SizedBox(
                  height: 80,
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(stateProvider.notifier).increment();
          },
        ),
      ),
    );
  }
}

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(
      stateProvider.select((value) => value.counter),
    );

    return Center(
        child: Text(
      viewModel.toString(),
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    ));
  }
}

class QuotesList extends ConsumerWidget {
  const QuotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final quotes = ref.watch(
      quotesProvider,
    );
    return quotes.when(
        data: (data) {
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: Builder(builder: (context) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        ),
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Text(
                            data[index].quote,
                            textAlign: TextAlign.center,
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
              ),
            ],
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => CircularProgressIndicator());
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
            .showSnackBar(SnackBar(content: Text('Login Success')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Failure')));
      }
    });
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Username'),
          onChanged: provider.onChangedUserName,
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Password'),
          onChanged: provider.onChangedPassword,
        ),
        ElevatedButton(
            onPressed: () {
              provider.login();
            },
            child: Text('Login'))
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
        print('selectedIndex: $selectedIndex');
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                ref.read(stateProvider.notifier).selectIndex(index);
              },
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
