import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';

enum CropAspectRatioType {
  personPhoto, // 240 x 320
  messagePhoto, // 640 x 640
}

class PtdImage extends StatefulWidget {
  /// *PtdImage*
  /// Show and change image
  ///
  /// Sample:
  /// ```
  /// PtdImage(
  ///   imageUrl: 'https://example.com/image.jpg',
  ///   name: 'eduardoxyz4565',
  ///   height: 120,
  ///   width: 90,
  ///   placeholder: Icon(Icons.image, size: 70, color: Colors.grey),
  ///   cropAspectRatio: CropAspectRatioType.personPhoto,
  ///   onChanged: (url) => print('Url mudou para $url'),
  ///   onError: (error) => print('erro: $error'),
  /// )
  /// ```
  const PtdImage({
    super.key,
    this.imageUrl,
    required this.name,
    required this.height,
    required this.width,
    required this.cropAspectRatio,
    this.placeholder,
    this.onChanged,
    this.onError,
  });

  final String? imageUrl;
  final String name;
  final double height;
  final double width;
  final Widget? placeholder;
  final CropAspectRatioType cropAspectRatio;
  final void Function(String? url)? onChanged;
  final void Function(Object? error)? onError;

  @override
  State<PtdImage> createState() => _PtdImageState();
}

class _PtdImageState extends State<PtdImage> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.surface,
      child: InkWell(
        onTap: () async {
          if (widget.onChanged != null) {
            await uploadImage(context, widget.name);
          }
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: context.color.onSurface.withOpacity(0.2),
                offset: const Offset(-2, 2),
                spreadRadius: 2,
                blurRadius: 1,
              ),
            ],
          ),
          child: (imageUrl != null)
              ? Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.contain,
                      progressIndicatorBuilder: (context, url, progress) =>
                          const CircularProgressIndicator.adaptive(),
                    ),
                  ),
                )
              : Center(child: widget.placeholder ?? const SizedBox.shrink()),
        ),
      ),
    );
  }

  Future<void> uploadImage(BuildContext context, String filename) async {
    final firebaseStorage = FirebaseStorage.instance;

    final action = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Escolha uma opção',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Selecionar da galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'Escolha uma imagem da galeria para enviar',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  // 0 para selecionar imagem da galeria
                  Navigator.of(context).pop(0);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Tirar uma foto',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'Use a câmera para capturar uma nova foto',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  // 1 para tirar nova foto usando mobile
                  Navigator.of(context).pop(1);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(
                  'Limpar foto',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'Remova a foto do pet',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  // Definir a URL da imagem como vazia
                  setState(() {
                    imageUrl = '';
                  });
                  if (widget.onChanged != null) widget.onChanged!('');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    if (action == null) return;

    final imagePicker = ImagePicker();

    try {
      XFile? image;
      if (action == 0) {
        // Seleciona imagem da galeria
        image = await imagePicker.pickImage(source: ImageSource.gallery);
      } else if (action == 1) {
        // Tira uma nova foto usando mobile
        image = await imagePicker.pickImage(source: ImageSource.camera);
      }

      if (image != null) {
        Uint8List? croppedImage =
            await cropImage(File(image.path), widget.cropAspectRatio);

        // Upload para o Firebase Storage
        final snapshot = await firebaseStorage
            .ref()
            .child('photos/$filename.jpg')
            .putData(croppedImage);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        if (widget.onChanged != null) widget.onChanged!(downloadUrl);
      }
    } catch (error) {
      if (widget.onError != null) widget.onError!(error);
    }
  }

  Future<void> takePictureAndDisplay(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      // Inicializar o controller da câmera
      final CameraController controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();

      // Exibir o CameraPreview
      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: CameraPreview(controller),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final XFile image = await controller.takePicture();
                      if (context.mounted) Navigator.of(context).pop();

                      final firebaseStorage = FirebaseStorage.instance;
                      // Realizar o recorte da imagem
                      Uint8List? croppedImage = await cropImage(
                          File(image.path), widget.cropAspectRatio);

                      await controller.dispose();

                      // Upload para o Firebase Storage
                      final filePath =
                          'photos/${widget.name.isNotEmpty ? widget.name : const Uuid().v4()}.jpg'; // Corrigido para Uuid
                      final snapshot = await firebaseStorage
                          .ref()
                          .child(filePath)
                          .putData(croppedImage);
                      final downloadUrl = await snapshot.ref.getDownloadURL();
                      setState(() {
                        imageUrl = downloadUrl;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(downloadUrl);
                      }
                    } catch (error) {
                      if (widget.onError != null) widget.onError!(error);
                    }
                  },
                  child: const Text('Tirar Foto'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      if (widget.onError != null) widget.onError!(error);
    }
  }

  Future<Uint8List> cropImage(
      File imageFile, CropAspectRatioType aspectRatioType) async {
    int maxWidth;
    int maxHeight;
    if (aspectRatioType == CropAspectRatioType.personPhoto) {
      maxWidth = 240;
      maxHeight = 320;
    } else {
      maxWidth = 640;
      maxHeight = 640;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      aspectRatio: aspectRatioType == CropAspectRatioType.personPhoto
          ? const CropAspectRatio(ratioX: 3, ratioY: 4)
          : const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Foto',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Recortar foto',
          doneButtonTitle: 'Cortar',
          cancelButtonTitle: 'Cancelar',
        ),
      ],
    );

    if (croppedFile != null) {
      final convertedImage = await croppedFile.readAsBytes();
      return convertedImage;
    } else {
      throw Exception('Image cropping failed');
    }
  }
}
