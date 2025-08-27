// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class KeyValueWidget extends StatelessWidget {
  String title;
  String? value;
  Widget? customValueWidget;
  KeyValueWidget(
      {Key? key, required this.title, this.value, this.customValueWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.black.withOpacity(.4)),
          ),
        ),
        Expanded(
          child: customValueWidget ??
              Text(
                value ?? '',
                textAlign: TextAlign.end,
              ),
        ),
      ],
    );
  }
}
