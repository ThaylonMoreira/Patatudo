import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:patatudo/src/shared/extensions/extensions.dart';

import '../../domain/bloc/pet_list_bloc.dart';
import '../../domain/entities/pet.dart';
import '../../domain/states/pet_list_state.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

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
          PetListLoadSuccess(:final pets) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pets',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () => Modular.to.pushNamed(
                            './pet-list',
                            arguments: pets,
                          ),
                          child: const Text('Ver todos >'),
                        ),
                      ],
                    ),
                    Gap(context.smallGap),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 150,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        scrollDirection: Axis.horizontal,
                        itemCount: pets.length,
                        itemBuilder: (context, index) {
                          final pet = pets[index];
                          return _buildPetCard(pet, context);
                        },
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _buildSection(
                      context,
                      title: 'Saúde',
                      content: const Center(child: Text('Saúde Section')),
                    ),
                    _buildSection(
                      context,
                      title: 'Alimentação',
                      content: const Center(child: Text('Alimentação Section')),
                    ),
                    _buildSection(
                      context,
                      title: 'Compromissos',
                      content:
                          const Center(child: Text('Compromissos Section')),
                    ),
                    _buildSection(
                      context,
                      title: 'Passeios',
                      content: const Center(child: Text('Passeios Section')),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
        };
      },
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver todos >'),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: content,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildPetCard(Pet pet, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          './pet-detail',
          arguments: pet,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: pet.photo,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 40),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (1 > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
