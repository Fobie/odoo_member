import 'dart:convert';
import 'dart:io' as io;
import '../../constants.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common/size_config.dart';
import '../../models/common.dart';
import '../../view_models/user_vm.dart';

class UserImagePicker extends StatefulWidget {
  // const UserImagePicker({ Key? key }) : super(key: key);
  final Function(XFile? pickedImage) imagePickFn;
  final ImageType type;

  const UserImagePicker(this.imagePickFn, this.type, {super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  void _pickImage(source) async {
    final ImagePicker picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: source);
    if (pickedImageFile == null) return;
    _pickedImage = await _cropImage(imageFile: pickedImageFile);
    setState(() {
      _pickedImage = _pickedImage;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    widget.imagePickFn(_pickedImage);
  }

  Future<XFile?> _cropImage({required XFile imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 50,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return XFile(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizeText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: getProportionateScreenWidth(112),
        width: getProportionateScreenWidth(112),
        child: Stack(
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: widget.type == ImageType.profile
                    ? Consumer<UserVM>(
                        builder: (context, userData, child) => CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: (_pickedImage != null)
                                ? Image.file(
                                    io.File(_pickedImage!.path),
                                  )
                                : userData.user.base64Profile != ""
                                    ? Image.memory(
                                        base64Decode(
                                            userData.user.base64Profile),
                                      )
                                    : Image.asset(
                                        AssetImagePath.noProfilePicColor01),
                          ),
                          // : Image.network(
                          //     userData.user.img_url_128,
                          //     headers: {
                          //       "cookie": userData.user.session_id
                          //     },
                          //   ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (_pickedImage != null)
                              ? Image.file(
                                  io.File(_pickedImage!.path),
                                )
                              : Image.asset(AssetImagePath.noProfilePicColor01),
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(8),
                  ),
                  decoration: ShapeDecoration(
                      shape: const CircleBorder(side: BorderSide.none),
                      color: Theme.of(context).colorScheme.primary),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera),
                                icon: const Icon(Icons.camera_alt),
                                label: Text(localizeText.fromCameraLabel),
                              ),
                              TextButton.icon(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                icon: const Icon(Icons.image_outlined),
                                label: Text(localizeText.fromFileLabel),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
