import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Atraso de 3 segundos antes de navegar para ./home
    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.navigate('./home/'); // Navegação utilizando o Modular
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá mundo!',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
