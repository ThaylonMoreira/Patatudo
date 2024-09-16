import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:patatudo/src/shared/extensions/extensions.dart';

import '../../../domain/entities/pet.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              color: Colors.blueGrey, // Cor de fundo para melhor visualização
              child: CachedNetworkImage(
                imageUrl: pet.photo,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 80),
              ),
            ),
          ),
          Positioned(
            top: 150, // Ajuste conforme necessário
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    pet.name,
                    style: context.text.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${pet.breed} - ${pet.age}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.medical_services),
                    label: const Text('Get care'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(text: 'Visão Geral'),
                            Tab(text: 'Histórico'),
                            Tab(text: 'Saúde'),
                            Tab(text: 'Registros'),
                          ],
                          labelStyle: context.text.labelSmall,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 400,
                          child: TabBarView(
                            children: [
                              _buildOverviewSection(),
                              _buildHistorySection(),
                              _buildHealthSection(),
                              _buildRecordsSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100, // Ajuste a posição para ficar acima
            left: MediaQuery.of(context).size.width / 2 -
                60, // Centraliza horizontalmente
            child: CircleAvatar(
              radius: 60, // Ajuste o tamanho conforme necessário
              backgroundImage: CachedNetworkImageProvider(pet.photo),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return ListView(
      children: [
        _buildAppointmentsSection(),
        const SizedBox(height: 24),
        _buildPreventiveHealthCareSection(),
      ],
    );
  }

  Widget _buildAppointmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compromissos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          color: Colors.brown[100],
          child: const ListTile(
            leading: Icon(Icons.event_available, size: 40),
            title: Text('Vet Appointment'),
            subtitle: Text('Mon 24 Jan\n8:00 AM - Dr. Smith'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text('+ Adicionar'),
        ),
      ],
    );
  }

  Widget _buildPreventiveHealthCareSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saúde',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.medical_services, size: 40),
            title: Text('Internal deworming'),
            subtitle: Text('22 Days left\nBob Martin Internal Dewormer'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.medical_services, size: 40),
            title: Text('Flea medication'),
            subtitle: Text('6 Days left\nBob Martin Flea Medication'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text('+ Adicionar'),
        ),
      ],
    );
  }

  Widget _buildHistorySection() {
    return const Center(child: Text('History Section'));
  }

  Widget _buildHealthSection() {
    return const Center(child: Text('Health Section'));
  }

  Widget _buildRecordsSection() {
    return const Center(child: Text('Records Section'));
  }
}
