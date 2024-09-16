import 'package:flutter/material.dart';

import '../../../domain/entities/pet_type.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _genderController = TextEditingController();
  final _notesController = TextEditingController();
  PetType _selectedType = PetType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome do Pet'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<PetType>(
              value: _selectedType,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedType = newValue;
                  });
                }
              },
              items: PetType.values.map((PetType type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.alias.toString().split('.').last),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tipo de Pet'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _breedController,
              decoration: const InputDecoration(labelText: 'Raça'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Idade'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Peso'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _birthdayController,
              decoration:
                  const InputDecoration(labelText: 'Data de Nascimento'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _genderController,
              decoration: const InputDecoration(labelText: 'Gênero'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notas'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para adicionar o pet (por exemplo, salvar em um banco de dados)
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Salvar Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
