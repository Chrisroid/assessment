import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM Clean Architecture'),
      ),
      body: Center(
        child: homeState.when(
          data: (data) => Text(
            data,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(homeViewModelProvider.notifier).fetchData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
