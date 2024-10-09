import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/modular/go.dart';
import '../../../domain/bloc/pet_list_bloc.dart';
import '../../../domain/states/pet_list_state.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetListBloc, PetListState>(
      builder: (context, state) {
        return switch (state) {
          PetListInitial() ||
          PetListLoading() =>
            const CircularProgressIndicator.adaptive(),
          PetListLoadEmpty() => const Text('Nenhum pet encontrado.'),
          PetListLoadFailure(:final message) => Text(message),
          PetListLoadSuccess(:final pets) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.pets.length,
                      itemBuilder: (context, index) {
                        final pet = pets[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: pet.photo,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(pet.name),
                            subtitle: Text('${pet.breed} - ${pet.age}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () =>
                                  Go.to('./pet-detail', arguments: pet),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }
}
