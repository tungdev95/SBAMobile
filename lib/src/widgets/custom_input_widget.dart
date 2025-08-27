import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/bottomsheet/bottomsheet_dropdown.dart';
import 'package:sba/src/widgets/rounded_textfield.dart';

class CustomInputWidget extends ConsumerStatefulWidget {
  final InputFieldModel inputFieldModel;
  final InputFieldModel? nextInputModel;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final VoidCallback? onEditingComplete;
  //Không dùng chung biến enable trong InputFieldModel được
  final bool? enable;
  const CustomInputWidget({
    Key? key,
    required this.inputFieldModel,
    this.nextInputModel,
    this.padding,
    this.margin,
    this.contentPadding,
    this.enable,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  ConsumerState<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends ConsumerState<CustomInputWidget> {
  late TextEditingController _editingController;

  InputFieldModel get inputFieldModel => widget.inputFieldModel;

  @override
  void initState() {
    _editingController = inputFieldModel.textEditingController ??
        TextEditingController(text: getDefaultText());
    inputFieldModel.updateText = onUpdateText;
    inputFieldModel.setSelectedValue = (p0) {
      _editingController.text = p0?.title ?? '';
      inputFieldModel.selectedValue = p0;
      onTextChangeUpdate(p0?.title ?? '');
      inputFieldModel.onChange?.call(p0 ?? KeyValueModel());
    };
    super.initState();
  }

  String getDefaultText() {
    var defaultText = inputFieldModel.value ?? '';
    if (defaultText.isEmpty) {
      if (inputFieldModel.selectedValue != null) {
        defaultText = inputFieldModel.selectedValue?.title ?? '';
      } else if (inputFieldModel.data != null) {
        defaultText = inputFieldModel.getDataContent;
      }
    }
    return defaultText;
  }

  @override
  void dispose() {
    super.dispose();
    // inputFieldModel.dispose();
    _editingController.dispose();
  }

  String? onTextChangeUpdate(String text) {
    String? newText = text.isEmpty ? null : text;
    hasEditValue = true;
    inputFieldModel.value = newText;
    if (newText == null) {
      inputFieldModel.onTextChanged?.call(null);
      return null;
    }
    var type = inputFieldModel.runtimeType.toString();
    if (type.contains('int')) {
      var text = newText.replaceAll(RegExp(r'\D'), '');
      inputFieldModel.onTextChanged?.call(int.tryParse(text));
      return null;
    } else if (type.contains('double')) {
      try {
        var text = newText;
        if (text.isEmpty) {
          inputFieldModel.onTextChanged?.call(null);
          return null;
        }
        var value = formatterDouble.parse(text);
        inputFieldModel.value = text;
        inputFieldModel.onTextChanged?.call(value);
        if (inputFieldModel.isCurrency == true) {
          return null;
        }
        return text;
      } catch (e) {
        // log('Lỗi parse double: :$newText', error: e);
        inputFieldModel.onTextChanged?.call(null);
        return null;
      }
    } else if (type.contains('DateTime')) {
      try {
        var value = DateFormat(defaultFormat).parse(newText, true);
        inputFieldModel.onTextChanged?.call(value);
      } catch (e) {
        log('Lỗi parse DateTime: :$newText', error: e);
        inputFieldModel.onTextChanged?.call(null);
      }
      return null;
    } else {
      inputFieldModel.onTextChanged?.call(newText);
      return null;
    }
  }

  @override
  void didUpdateWidget(covariant CustomInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputFieldModel.selectedValue?.title !=
            inputFieldModel.selectedValue?.title ||
        oldWidget.inputFieldModel.value != inputFieldModel.value ||
        oldWidget.inputFieldModel.data != inputFieldModel.data) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _editingController.text = getDefaultText();
      });
    }
    inputFieldModel.updateText = onUpdateText;
    if (oldWidget.inputFieldModel.validator != inputFieldModel.validator) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.inputFieldModel.inputFieldType != InputFieldType.custom &&
              widget.inputFieldModel.showTitle) ...[
            Text.rich(
              TextSpan(
                text: inputFieldModel.label ?? '',
                children: [
                  if (inputFieldModel.isRequired == true)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
                style: context.textNormal.copyWith(
                  color: const Color(0xFF3F547B),
                ),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
          inputWidget(context, ref),
        ],
      ),
    );
  }

  Widget inputWidget(BuildContext context, WidgetRef ref) {
    switch (inputFieldModel.inputFieldType) {
      case InputFieldType.normal:
        return RoundedTextField(
          editingController: _editingController,
          inputFieldModel: inputFieldModel,
          contentPadding: widget.contentPadding,
          enabled: widget.enable ?? inputFieldModel.enable,
          onChanged: onTextChangeUpdate,
          onEditingComplete: () => toggleFocusField(context),
        );
      case InputFieldType.date:
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: RoundedTextField(
            editingController: _editingController,
            inputFieldModel: inputFieldModel,
            contentPadding: widget.contentPadding,
            onTap: () async {
              onSelectDateClicked(context, inputFieldModel);
            },
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: const Icon(Icons.calendar_month),
                onTap: () async {
                  onSelectDateClicked(context, inputFieldModel);
                },
              ),
            ),
          ),
        );
      case InputFieldType.customSelect:
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: RoundedTextField(
            editingController: _editingController,
            inputFieldModel: inputFieldModel,
            contentPadding: widget.contentPadding,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (inputFieldModel.onTap != null) {
                await inputFieldModel.onTap?.call(context, _editingController);
              }
              inputFieldModel.value = _editingController.text;
              onTextChangeUpdate(_editingController.text);
            },
            suffixIcon: inputFieldModel.suffixIcon != null
                ? inputFieldModel.suffixIcon!.call(context, _editingController)
                : Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      child: inputFieldModel.trailingIcon,
                      onTap: () async {
                        var isEnable = widget.enable ?? inputFieldModel.enable;
                        if (isEnable == false) return;
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (inputFieldModel.onTap != null) {
                          await inputFieldModel.onTap
                              ?.call(context, _editingController);
                        }
                        inputFieldModel.value = _editingController.text;
                        onTextChangeUpdate(_editingController.text);
                      },
                    ),
                  ),
          ),
        );
      case InputFieldType.dropDown:
        if (inputFieldModel.selectedItemProvider != null ||
            inputFieldModel.listDataProvider != null) {
          return loadingDropDownDataWidget(
            context,
            ref,
            inputFieldModel,
          );
        } else {
          return CustomDropDownWidget(
            inputFieldModel.label,
            inputFieldModel.lsDropDown ?? [],
            onTextChanged: (p0) {
              onTextChangeUpdate(p0);
            },
            inputFieldModel: inputFieldModel,
            enable: widget.enable ?? inputFieldModel.enable ?? true,
            selected: inputFieldModel.selectedValue,
            controller: _editingController,
            selectItemCallback: (newItem) async {
              onTextChangeUpdate(newItem.title);
              inputFieldModel.selectedValue = newItem;
              if (inputFieldModel.onChange != null) {
                await inputFieldModel.onChange?.call(newItem);
              }
            },
            validator: inputFieldModel.validator,
            checkBeforeShowItem: (value) {
              if (inputFieldModel.checkShowBottomSheet != null) {
                inputFieldModel.checkShowBottomSheet?.call(
                  (lstDropDownResult) {
                    value.call(lstDropDownResult);
                  },
                );
              } else {
                value.call(null);
              }
            },
          );
        }
      case InputFieldType.custom:
        return inputFieldModel.widgetBuilder?.call(
              context,
              ref,
              () {
                // notifier.reloadData();
              },
              inputFieldModel.data,
            ) ??
            const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget loadingDropDownDataWidget(
    BuildContext context,
    WidgetRef ref,
    // C notifier,
    // AssetsDetailState state,
    InputFieldModel inputFieldModel,
  ) {
    return HookConsumer(
      builder: (context, ref, child) {
        KeyValueModel? selectedItem;
        if (inputFieldModel.selectedItemProvider != null) {
          selectedItem = ref.watch(inputFieldModel.selectedItemProvider!);
        } else {
          selectedItem = inputFieldModel.selectedValue;
        }
        return CustomDropDownWidget(
          inputFieldModel.label,
          inputFieldModel.lsDropDown ?? [],
          inputFieldModel: inputFieldModel,
          enable: (widget.enable ?? (inputFieldModel.enable ?? true)),
          selected: selectedItem,
          controller: _editingController,
          allowShowLoading: true,
          onTextChanged: (p0) {
            onTextChangeUpdate(p0);
          },
          listDataProvider: inputFieldModel.listDataProvider,
          firstLoadedItemCallBack: (p0) async {
            if (inputFieldModel.firstLoadedItemCallBack != null) {
              await inputFieldModel.firstLoadedItemCallBack?.call(p0);
            }
          },
          selectItemCallback: (newItem) async {
            inputFieldModel.value = newItem?.title;
            inputFieldModel.selectedValue = newItem;
            _editingController.text = newItem?.title ?? '';
            onTextChangeUpdate(newItem?.title ?? '');
            if (inputFieldModel.selectedItemProvider != null) {
              ref
                  .read(inputFieldModel.selectedItemProvider!.notifier)
                  .update((state) => newItem);
            }
            if (inputFieldModel.onChange != null) {
              await inputFieldModel.onChange?.call(newItem);
            }
            // toggleFocusField(context);
          },
          validator: inputFieldModel.validator,
          checkBeforeShowItem: (value) {
            if (inputFieldModel.checkShowBottomSheet != null) {
              inputFieldModel.checkShowBottomSheet?.call((lstDropDownResult) {
                value(lstDropDownResult);
              });
            } else {
              value(null);
            }
          },
        );
      },
    );
  }

  void onSelectDateClicked(BuildContext context, InputFieldModel item) async {
    var isEnable = widget.enable ?? inputFieldModel.enable;
    if (isEnable == false) return;
    FocusScope.of(context).requestFocus(FocusNode());
    final result = await showDatePickerSelect(
      context,
      inputFieldModel.data ?? DateTime.now(),
    );
    if (result != null) {
      _editingController.text = result.toStringFormat();
      inputFieldModel.data = result.toUtc();
      inputFieldModel.value = _editingController.text;
      onTextChangeUpdate(_editingController.text);
    }
  }

  Future<DateTime?> showDatePickerSelect(
    BuildContext context,
    DateTime currentDate, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: currentDate,
      locale: const Locale('vi'),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2040),
    );
  }

  void toggleFocusField(BuildContext context) {
    if (inputFieldModel.inputAction == TextInputAction.next) {
      if (widget.nextInputModel != null) {
        // && (widget.nextInputModel?.content() ?? '').isEmpty
        FocusScope.of(context).requestFocus(widget.nextInputModel?.focusNode);
        return;
      } else {
        hideKeyboard();
      }
    } else {
      hideKeyboard();
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onUpdateText(String p0) {
    var textChangedResult = onTextChangeUpdate(p0);
    _editingController.text = textChangedResult ?? p0;
  }
}
