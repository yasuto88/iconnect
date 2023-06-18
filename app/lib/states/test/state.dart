import 'package:app/states/test/s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s3 = ref.watch(s3NotifierProvider);
    final widget = s3.when(
        data: (d) => Text(d),
        error: (e, s) => Text('エラーが出ました$e'),
        loading: () => const Text('準備中'));

    final button = ElevatedButton(
        onPressed: () {
          final notifier = ref.read(s3NotifierProvider.notifier);
          notifier.updateState();
        },
        child: Text('buttom'));

    return Column(
      children: [widget, button],
    );
  }
}
