// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../i18n/generated_locales/l10n.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/base_text.dart';
import '../../../widgets/bottom_contact.dart';
import '../../../widgets/loading_circle_widget.dart';

class ActiveKeyScreen extends StatefulWidget {
  const ActiveKeyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GenerateCerKeyState();
}

class _GenerateCerKeyState extends State<ActiveKeyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.generateCerKey,
      hiddenIconBack: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // const ImageSliderWidget(),
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 20),
                    child: LoadingCircleWidget(
                      title: AppLocalizations.current.initializingKeyPair,
                      subtitle: AppLocalizations
                          .current.initializingKeyPairDescription,
                    ),
                  )
                ],
              ),
            ),
          ),
          const BottomContact(),
        ],
      ),
    );
  }
}

class InfoNotifyWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String content;
  final EdgeInsets? margin;

  const InfoNotifyWidget(
      {Key? key, this.image, this.title, required this.content, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          if (image?.isNotEmpty ?? false)
            Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Image.asset(
                  image!,
                  width: 100,
                )),
          if (title?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: BaseText(
                title,
                fontSize: 16,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: const Color(0xff08285C),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: BaseText(
              content,
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w400,
              color: const Color(0xff08285C),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
