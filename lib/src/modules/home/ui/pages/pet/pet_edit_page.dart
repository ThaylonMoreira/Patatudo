import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patatudo/src/shared/extensions/extensions.dart';

import '../../../../../core/modular/find.dart';
import '../../../../../core/modular/go.dart';
import '../../../../../shared/design/design.dart';
import '../../../../../shared/functions/functions.dart';
import '../../../domain/bloc/pet_edit_bloc.dart';
import '../../../domain/entities/pet.dart';
import '../../../domain/entities/pet_type.dart';
import '../../../domain/events/pet_edit_event.dart';
import '../../../domain/states/pet_edit_state.dart';

class PetEditPage extends StatefulWidget {
  const PetEditPage({super.key, this.pet});

  final Pet? pet;

  @override
  State<PetEditPage> createState() => _PetEditPageState();
}

class _PetEditPageState extends State<PetEditPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _breedController;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _genderController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final pet = widget.pet;

    if (pet.isNull) {
      Find.i<PetEditBloc>().add(const PetCreateStarted());
      _nameController = TextEditingController();
      _breedController = TextEditingController();
      _ageController = TextEditingController();
      _weightController = TextEditingController();
      _birthdayController = TextEditingController();
      _genderController = TextEditingController();
      _notesController = TextEditingController();
    } else {
      Find.i<PetEditBloc>().add(PetUpdateStarted(pet!));
      _nameController = TextEditingController(text: pet.name);
      _breedController = TextEditingController(text: pet.breed);
      _ageController = TextEditingController(text: pet.age);
      _weightController = TextEditingController(text: pet.weight);
      _birthdayController = TextEditingController(text: pet.birthday);
      _genderController = TextEditingController(text: pet.gender);
      _notesController = TextEditingController(text: pet.notes);
    }
  }

  @override
  void dispose() {
    disposeAll([
      _nameController,
      _breedController,
      _ageController,
      _weightController,
      _birthdayController,
      _genderController,
      _notesController,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet.isNull ? 'Adicionar Pet' : 'Alteração de Pet'),
      ),
      body: SafeArea(
        top: false,
        child: Container(
          color: context.color.surface,
          padding: EdgeInsets.all(context.smallGap),
          child: BlocConsumer<PetEditBloc, PetEditState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.all(context.smallGap),
                      children: [
                        Center(
                          child: PtdImage(
                            imageUrl: widget.pet.isNotNull &&
                                    widget.pet!.photo.isNotEmpty
                                ? widget.pet!.photo
                                : null,
                            name: widget.pet.isNotNull ? widget.pet!.id : '',
                            height: 120,
                            width: 90,
                            placeholder: FaIcon(
                              FontAwesomeIcons.solidPaw,
                              size: 70,
                              color: context.color.onSurface.withOpacity(0.5),
                            ),
                            onChanged: (url) => context
                                .read<PetEditBloc>()
                                .add(PetPhotoChanged(url!)),
                            cropAspectRatio: CropAspectRatioType.personPhoto,
                            onError: (error) => dprint('erro: $error'),
                          ),
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetNameChanged(value));
                          },
                          validator: (_) => state.nameValidator,
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<PetType>(
                          value: state.pet.type,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context
                                  .read<PetEditBloc>()
                                  .add(PetTypeChanged(newValue));
                            }
                          },
                          items: PetType.values.map((PetType type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.alias),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Tipo',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _breedController,
                          decoration: const InputDecoration(labelText: 'Raça'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetBreedChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Idade'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetAgeChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _weightController,
                          decoration: const InputDecoration(labelText: 'Peso'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetWeightChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _birthdayController,
                          decoration: const InputDecoration(
                              labelText: 'Data de Nascimento'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetBirthdayChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _genderController,
                          decoration:
                              const InputDecoration(labelText: 'Gênero'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetGenderChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(labelText: 'Notas'),
                          onChanged: (value) {
                            context
                                .read<PetEditBloc>()
                                .add(PetNotesChanged(value));
                          },
                          onTapOutside: (_) => context.closeKeyboard(),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: state.formValidator &&
                                  state.status != PetEditStatus.initial
                              ? () {
                                  context.read<PetEditBloc>().add(
                                      PetEditSubmitted(
                                          widget.pet ?? const Pet.empty()));
                                  Go.pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: state.status == PetEditStatus.submitting
                              ? const CircularProgressIndicator()
                              : Text(widget.pet.isNull
                                  ? 'Criar pet'
                                  : 'Atualizar pet'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
