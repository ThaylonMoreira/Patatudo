import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/modular/go.dart';
import '../../../shared/extensions/extensions.dart';
import '../domain/bloc/pet_list_bloc.dart';
import '../domain/states/pet_list_state.dart';
import 'widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de títulos para cada índice
  final List<String> _titles = [
    '',
    'Calendário',
    'Pets',
    'Saúde',
    'Passeios',
  ];

  @override
  void initState() {
    super.initState();
    Go.to('./home');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.surface,
      child: Center(
        child: BlocBuilder<PetListBloc, PetListState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(_titles[_selectedIndex]),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {},
                  ),
                ],
              ),
              body: SafeArea(
                top: false,
                child: Container(
                  color: context.color.primaryContainer,
                  child: Center(
                    child: switch (state) {
                      PetListInitial() ||
                      PetListLoading() =>
                        const CircularProgressIndicator.adaptive(),
                      PetListLoadEmpty() => const HomeWidget(),
                      PetListLoadFailure(:final message) => Text(message),
                      PetListLoadSuccess() => const RouterOutlet(),
                    },
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                iconSize: 20,
                unselectedFontSize: 10,
                selectedFontSize: 12,
                unselectedIconTheme: const IconThemeData(size: 20),
                selectedIconTheme: const IconThemeData(size: 22),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Início',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Calendário',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pets),
                    label: 'Pets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_hospital),
                    label: 'Saúde',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_walk),
                    label: 'Passeios',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });

                  switch (index) {
                    case 0:
                      Go.to('./home');
                      break;
                    case 1:
                      Go.to('/appointment');
                      break;
                    case 2:
                      Go.to('./pet-list');
                      break;
                    case 3:
                      Go.to('/health_record');
                      break;
                    case 4:
                      Go.to('/walk_record');
                      break;
                  }
                },
                type: BottomNavigationBarType.fixed,
              ),
            );
          },
        ),
      ),
    );
  }
}
