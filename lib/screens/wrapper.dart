import 'package:buzzer/screens/authenticate/authenticate.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) {
          return const Home();
        }

        return const Authenticate();
      },
      error: (Object error, StackTrace? stackTrace) {
        return Container();
      },
      loading: () {
        return const Loading();
      },
    );
  }
}
