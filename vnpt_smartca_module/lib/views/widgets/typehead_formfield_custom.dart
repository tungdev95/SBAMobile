// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/utils/config_input_decoration.dart';

import '../utils/color.dart';
import 'base_text.dart';

class TypeAheadFormFieldCustom<T> extends StatelessWidget {
  const TypeAheadFormFieldCustom({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.suggestionsCallback,
    this.validator,
    this.onSelectedCallback,
    this.doublePadding = 16,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;

  final Function(String)? suggestionsCallback;
  final String? Function(String?)? validator;
  final String Function(dynamic option)? onSelectedCallback;
  final double doublePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: doublePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            labelText,
            isRequired: true,
            fontWeight: FontWeight.w600,
            color: const Color(0xff08285C),
          ),
          const SizedBox(
            height: 10,
          ),
          TypeAheadField(
            controller: controller,
            builder: (context, controller, focusNode) => TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 180),
              decoration: ConfigInputDecoration().config(
                "",
                borderColor: Color(0xffA5B0C2),
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.text = "";
                  },
                  icon: Icon(Icons.close),
                  color: Color(0xff5768A5),
                ),
              ),
            ),
            emptyBuilder: (context) => SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  AppLocalizations.current.dataNotFound,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HexColor("#6079A0"),
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                ),
              ),
            ),
            itemBuilder: (context, suggestion) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text((suggestion as dynamic)?.name ?? ''),
              );
            },
            onSelected: (value) {
              if (validator != null &&
                  validator!((value as dynamic)?.name) == "") {
                onSelectedCallback?.call(value);
              } else {
                onSelectedCallback?.call(value);
              }
            },
            suggestionsCallback: (search) {
              return suggestionsCallback?.call(search);
            },
          )
        ],
      ),
    );
  }
}
