// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';

import '../../src/utils/resourse_utils.dart';

class SearchWidget extends StatelessWidget {
  String? hint;
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  FocusNode? focus;
  bool? enable;
  TextEditingController? controller;

  SearchWidget({
    super.key,
    this.hint,
    this.focus,
    this.enable = true,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      focusNode: focus,
      enabled: enable,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.white,
        filled: true,
        hintText: hint ?? '',
        hintStyle: context.textMedium.copyWith(
          color: const Color(0xFF8190AD),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 50, maxHeight: 35),
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: const Image(
            image: AssetImage(ImageName.ic_search),
          ),
        ),
        suffixIcon: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            controller?.clear();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
