import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patatudo/src/modules/home/ui/widgets/home_widget.dart';
import 'package:patatudo/src/shared/extensions/extensions.dart';

import '../domain/bloc/pet_list_bloc.dart';
import '../domain/states/pet_list_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, './home');
        break;
      case 1:
        Navigator.pushNamed(context, './pet-list');
        break;
      case 2:
        Navigator.pushNamed(context, '/feeding_record');
        break;
      case 3:
        Navigator.pushNamed(context, '/health_record');
        break;
      case 4:
        Navigator.pushNamed(context, '/appointment');
        break;
      case 5:
        Navigator.pushNamed(context, '/walk_record');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.surface,
      child: Center(
        child: BlocBuilder<PetListBloc, PetListState>(
          builder: (context, state) {
            return Scaffold(
              drawer: const Drawer(),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
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
                      PetListLoadEmpty() => const HomeWidget(pets: []),
                      PetListLoadFailure(:final message) => Text(message),
                      PetListLoadSuccess(:final pets) => HomeWidget(pets: pets),
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
                    icon: Icon(Icons.pets),
                    label: 'Pets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fastfood),
                    label: 'Alimentação',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_hospital),
                    label: 'Saúde',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Compromissos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_walk),
                    label: 'Passeios',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
              ),
            );
          },
        ),
      ),
    );
  }
}
