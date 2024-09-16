import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

BindConfig<T> blocBindConfig<T extends Bloc>() {
  return BindConfig(
    notifier: (bloc) => bloc.stream,
    onDispose: (bloc) => bloc.close(),
  );
}
