import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:m13_native_device/widgets/location_input.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await _storedImage!.copy("${appDir.path}/$fileName");
    widget.onSelectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              alignment: Alignment.center,
              child: _storedImage != null
                  ? Image.file(
                      _storedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : const Text(
                      "No image taken",
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(
              Icons.camera,
              color: Colors.white,
            ),
            label: const Text("Take picture"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
