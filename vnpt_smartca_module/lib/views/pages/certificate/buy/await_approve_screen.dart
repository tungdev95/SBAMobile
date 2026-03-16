import 'package:flutter/material.dart';

import '../../../i18n/generated_locales/l10n.dart';
import '../../../widgets/bottom_contact.dart';
import '../../../widgets/widget.dart';

class AwaitApproveScreen extends StatefulWidget {
  const AwaitApproveScreen({super.key});

  @override
  State<AwaitApproveScreen> createState() => _AwaitApproveScreenState();
}

class _AwaitApproveScreenState extends State<AwaitApproveScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hiddenIconBack: false,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // const ImageSliderWidget(),
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 20),
                    child: LoadingCircleWidget(
                      title: AppLocalizations.current.await_approve_cert,
                      subtitle: AppLocalizations.current.waitaMinute,
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
