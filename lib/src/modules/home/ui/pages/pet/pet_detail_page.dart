import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../shared/extensions/extensions.dart';
import '../../../domain/entities/pet.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pet.name,
        ),
      ),
      body: Container(
        color: context.color.primaryContainer,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Card(
              child: Text(pet.name),
            )
          ],
        ),
      ),
    );
  }
}
