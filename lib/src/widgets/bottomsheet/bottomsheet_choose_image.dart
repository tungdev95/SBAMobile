import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:collection/collection.dart';

class ChooseImageBottomSheet extends StatefulWidget {
  const ChooseImageBottomSheet({super.key});

  @override
  _ChooseImageBottomSheetState createState() => _ChooseImageBottomSheetState();
}

class _ChooseImageBottomSheetState extends State<ChooseImageBottomSheet> {
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Upload ảnh'.toUpperCase(),
            style: context.textTitleMedium,
          ),
        ),
        const Divider(),
        ListView(
          shrinkWrap: true,
          children: [
            _buildAction('Chụp ảnh', Icons.camera_alt, () async {
              // print('Chụp ảnh');
              final result = await picker.pickImage(
                  source: ImageSource.camera, maxWidth: 2048);
              if (result != null) {
                showLoadingDialog();

                final List<XFile> resultImage = [];
                XFile? newFile;
                try {
                  final ByteData fontZip =
                      await rootBundle.load('assets/font/roboto_custom.zip');
                  var receivePort = ReceivePort();
                  var params = DecodeParam(result, await result.readAsBytes(),
                      fontZip, receivePort.sendPort);
                  debugPrint(
                      'Start: ${DateTime.now().toStringFormat('HH:mm:ss')}');
                  await Isolate.spawn(drawTextToImage, params);
                  // var imageResult = await drawTextToImage(params);

                  // Get the processed image from the isolate.
                  Uint8List imageData = await receivePort.first as Uint8List;
                  newFile = XFile.fromData(
                    imageData,
                    name: result.name,
                    mimeType: result.name.split('.').lastOrNull,
                    path: result.path,
                  );
                } finally {
                  hideLoadingDialog();
                  if (newFile != null) {
                    resultImage.add(newFile);
                    Navigator.of(context).pop(resultImage);
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              } else {
                Navigator.of(context).pop();
              }
            }),
            const Divider(
              height: 0,
            ),
            _buildAction('Chọn từ thư viện', Icons.photo_outlined, () async {
              try {
                final List<XFile> result = await picker.pickMultiImage(
                  maxWidth: 2048,
                );
                if (result.isNotEmpty) {
                  Navigator.of(context).pop(result);
                } else {
                  Navigator.of(context).pop();
                }
              } catch (error) {
                print(error);
              }
            })
          ],
        )
      ],
    );
  }

// final ByteData fontZip =
//   await rootBundle.load('assets/font/roboto_custom.zip');

  ListTile _buildAction(String title, IconData icon, VoidCallback callback) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        callback.call();
      },
    );
  }

  void showLoadingDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingWidget(),
          ),
        );
      },
      routeSettings: const RouteSettings(name: 'loadingDialog'),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).pop();
  }
}

void drawTextToImage(DecodeParam params) {
  ByteData fontZip = params.fontZip;
  // final fontZip = File('test/res/font/test.zip').readAsBytesSync();
  Uint8List fontUint8List =
      fontZip.buffer.asUint8List(fontZip.offsetInBytes, fontZip.lengthInBytes);
  final font = img.readFontZip(fontUint8List);
//arial_48
  img.Image? image = img.decodeImage(params.imageData);
  image = img.drawString(
    image!,
    font: font,
    x: 10,
    y: 10,
    '${DateTime.now().toStringFormat('dd/MM/yyyy hh:mm:ss aa')} \n ',
  );
  var imageData = Uint8List.fromList(img.encodeJpg(image));
  params.sendPort.send(imageData);
  // return newFile;
}

class DecodeParam {
  final XFile file;
  final Uint8List imageData;
  final ByteData fontZip;
  final SendPort sendPort;
  DecodeParam(this.file, this.imageData, this.fontZip, this.sendPort);
}
