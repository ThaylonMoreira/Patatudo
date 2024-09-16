import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/pet.dart';
import 'pet_create_page.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key, required this.pets});

  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Pets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar para a página de adicionar pet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPetPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return _buildPetListItem(pet, context);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                // Navegar para a página de adicionar pet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPetPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Pet'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetListItem(Pet pet, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: pet.photo,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(pet.name),
        subtitle: Text('${pet.breed} - ${pet.age}'),
        trailing: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            // Navegar para a página de detalhes do pet usando Modular
            Modular.to.pushNamed('./pet-detail', arguments: pet);
          },
        ),
      ),
    );
  }
}
