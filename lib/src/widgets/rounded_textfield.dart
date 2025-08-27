import 'package:flutter/material.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/utils.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    required TextEditingController editingController,
    required this.inputFieldModel,
    this.enabled,
    this.filled,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.contentPadding,
  }) : _editingController = editingController;

  final TextEditingController _editingController;
  final InputFieldModel inputFieldModel;
  final bool? enabled;
  final bool? filled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    bool isEnable = enabled ?? inputFieldModel.enable ?? true;
    return TextFormField(
      controller: _editingController,
      textInputAction: inputFieldModel.inputAction,
      inputFormatters: inputFieldModel.inputFormatter,
      keyboardType: inputFieldModel.inputType,
      validator: inputFieldModel.validator,
      focusNode: inputFieldModel.focusNode,
      maxLines: inputFieldModel.maxLines,
      minLines: inputFieldModel.minLines,
      onChanged: onChanged,
      autovalidateMode: inputFieldModel.autoValidateMode,
      enabled: isEnable,
      onEditingComplete: onEditingComplete,
      readOnly: inputFieldModel.readOnly ?? false,
      onTap: onTap,
      maxLength: inputFieldModel.maxLength,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: context.textNormal.copyWith(
          color: Colors.grey.shade500,
        ),
        disabledBorder: OutlineInputBorder(
          // borderSide: BorderSide(color: Theme.of(context).disabledColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: filled,
        fillColor: isEnable ? Colors.white : AppColor.disableColor,
        enabled: enabled ?? true,
        contentPadding: contentPadding ??
            ((inputFieldModel.maxLines ?? 1) > 1
                ? const EdgeInsets.all(16)
                : const EdgeInsets.symmetric(horizontal: 8)),
        hintText: isEnable ? inputFieldModel.hint : '',
        hintStyle: context.textNormal.copyWith(
          color: Colors.grey.shade500,
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error, // or any other color
        ),
        suffixIconConstraints: const BoxConstraints(maxWidth: 84),
        suffixIcon: suffixIcon,
        prefixIconConstraints: const BoxConstraints(maxHeight: 48),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: prefixIcon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
