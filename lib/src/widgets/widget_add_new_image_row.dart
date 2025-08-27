import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sba/src/utils/resourse_utils.dart';

import 'bottomsheet/bottomsheet_choose_image.dart';

class WidgetAddNewImage extends StatelessWidget {
  final Function(List<XFile>)? addImageComplete;

  const WidgetAddNewImage({super.key, this.addImageComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              List<XFile> result =
                  (await showSelectImageBottomSheet(context)) ?? [];
              if (addImageComplete != null && result.isNotEmpty) {
                addImageComplete?.call(result);
              }
            },
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Image(
                    width: 24,
                    height: 24,
                    image: AssetImage(ImageName.ic_image_file_add),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "",
          maxLines: 1,
        )
      ],
    );
  }

  Future<List<XFile>?> showSelectImageBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ChooseImageBottomSheet();
        });
  }
}
