import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueWidget<T> extends HookConsumerWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final String? title;

  const AsyncValueWidget({
    Key? key,
    this.title,
    required this.value,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: (title != null)
          ? AppBar(
              title: Text(title!),
            )
          : null,
      backgroundColor: Colors.white,
      body: value.when(
        data: ((item) {
          return Stack(
            children: [
              data(item),
            ],
          );
        }),
        loading: () => const LoadingWidget(),
        error: (e, _) {
          return Container(
            color: Colors.blueGrey,
          );
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
