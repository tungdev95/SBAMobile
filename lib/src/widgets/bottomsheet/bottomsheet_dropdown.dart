import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/widgets/rounded_textfield.dart';
import 'bottomsheet_dropdown_select.dart';

typedef SelectItemCallback<DropDownModel> = Function(DropDownModel);

// ignore: must_be_immutable
class CustomDropDownWidget extends ConsumerStatefulWidget {
  final InputFieldModel inputFieldModel;
  final List<KeyValueModel> lsDropDown;
  KeyValueModel? selected;
  final String? label;
  final SelectItemCallback? selectItemCallback;

  ///Dùng cho trường hợp chỉ cung cấp id, load data từ server xong trả thông tin item về để hiển thị
  final SelectItemCallback? firstLoadedItemCallBack;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  void Function(dynamic)? onTextChanged;
  final bool enable;
  final Function(Function(AutoDisposeFutureProvider<List<KeyValueModel>>?))?
      listDataProvider;
  //Dùng cho trường hợp load data online
  final bool allowShowLoading;
  final Function(Function(List<KeyValueModel>?)) checkBeforeShowItem;
  final Widget? prefixIcon;

  CustomDropDownWidget(
    this.label,
    this.lsDropDown, {
    required this.inputFieldModel,
    required this.selected,
    this.controller,
    this.selectItemCallback,
    this.validator,
    this.focusNode,
    this.onTextChanged,
    this.allowShowLoading = false,
    this.enable = false,
    this.listDataProvider,
    required this.checkBeforeShowItem,
    this.prefixIcon,
    this.firstLoadedItemCallBack,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CustomDropDownWidget> createState() {
    return _CustomDropDownWidgetState();
  }

  // @override
  // _CustomDropDownWidgetState createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends ConsumerState<CustomDropDownWidget> {
  bool enableEdit = false;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      textController = TextEditingController();
    } else {
      textController = widget.controller!;
    }
    textController.text = widget.selected?.title ?? '';
    enableEdit = widget.inputFieldModel.checkAllowEnterText
            ?.call(widget.selected?.key ?? '') ??
        false;

    fetchDefaultData();
    widget.inputFieldModel.onClickTrigger = () {
      onSelectValue();
    };
  }

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      editingController: textController,
      inputFieldModel: widget.inputFieldModel,
      enabled: widget.inputFieldModel.enable ?? true,
      // readOnly: true,
      onChanged: (value) => widget.onTextChanged?.call(value),
      onTap: onSelectValue,
      suffixIcon: widget.enable == true
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (widget.enable == false) return;
                    onSelectValue();
                  },
                )
              ],
            )
          : null,
    );
  }

  Future<void> onSelectValue() async {
    if (!widget.enable) return;
    // if (widget.lsDropDown.isEmpty) return;
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.checkBeforeShowItem((newListDropDown) async {
      //Kiểm tra điều kiện show dropdown
      var selectResult = await showModalBottomSheet<KeyValueModel>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: DraggableScrollableSheet(
              minChildSize: .5,
              maxChildSize: .9,
              initialChildSize: .5,
              expand: false,
              builder: (context, controller) {
                return Consumer(
                  builder: (context, ref, child) {
                    if (widget.listDataProvider != null) {
                      return widget.listDataProvider?.call(
                        (p0) {
                          return ref.watch(p0!).when(
                            data: (lsItem) {
                              return DropDownSelectionBottomSheet(
                                title: widget.label ?? '',
                                lsDropDown: lsItem,
                                selected: widget.selected,
                                controller: controller,
                                deleteClicked: () {
                                  widget.selected = null;
                                  widget.controller?.text = '';
                                  if (widget.selectItemCallback != null) {
                                    widget.selectItemCallback?.call(null);
                                  }
                                },
                              );
                            },
                            error: (e, msg) {
                              return const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    'Không có dữ liệu',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            },
                            loading: () {
                              return SizedBox(
                                height: context.screenSize.height * 2 / 5,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return DropDownSelectionBottomSheet(
                        title: widget.label ?? '',
                        lsDropDown: newListDropDown ?? widget.lsDropDown,
                        selected: widget.selected,
                        controller: controller,
                        deleteClicked: () {
                          widget.selected = null;
                          widget.controller?.text = '';
                          if (widget.selectItemCallback != null) {
                            widget.selectItemCallback?.call(null);
                          }
                        },
                      );
                    }
                  },
                );
              },
            ),
          );
        },
        // enableDrag: true,
      );

      if (selectResult == null) return;
      var isAllowEdit = widget.inputFieldModel.checkAllowEnterText
              ?.call(selectResult.key ?? '') ??
          false;
      if (isAllowEdit) {
        widget.selected = KeyValueModel(
            id: selectResult.id, key: selectResult.key, title: '', value: '');
        widget.controller?.text = '';
        if (widget.selectItemCallback != null) {
          widget.selectItemCallback!(widget.selected);
        }
        setState(
          () {
            enableEdit = true;
          },
        );
      } else {
        widget.selected = selectResult;
        widget.controller?.text = selectResult.title ?? '';
        if (widget.selectItemCallback != null) {
          widget.selectItemCallback?.call(selectResult);
        }
        setState(() {
          enableEdit = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomDropDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (textController.text != widget.selected?.title) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        textController.text = widget.selected?.title ?? '';
        fetchDefaultData();
      });
    }
  }

  void fetchDefaultData() async {
    if (!mounted) return;
    if ((widget.selected?.title ?? '').isEmpty &&
        (widget.selected?.key ?? '').isNotEmpty) {
      if (widget.listDataProvider != null) {
        final selectedKey = widget.selected?.key ?? '';
        widget.listDataProvider?.call(
          (data) {
            if (data != null) {
              ref.read(data.future).then(
                (value) {
                  final result = value.firstWhereOrNull(
                      (element) => element.key == selectedKey);
                  if (!mounted) return;
                  setState(
                    () {
                      textController.text = result?.title ?? '';
                      widget.selected?.title = result?.title;
                      widget.inputFieldModel.value = result?.title;
                      if (widget.firstLoadedItemCallBack != null) {
                        widget.firstLoadedItemCallBack?.call(result);
                      }
                    },
                  );
                },
              );
            }
          },
        );
      }
    }
  }
}
