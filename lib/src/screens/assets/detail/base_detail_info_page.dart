import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';

abstract class BaseDetailInfoPage<M extends BaseDetailItemState,
    T extends BaseDetailInfoPageController<M>> extends BasePage<T, M> {
  const BaseDetailInfoPage({super.key});

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, M state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerWidget(context, ref, state),
          Form(
            key: ref.read(provider(ref).notifier).detailKey,
            autovalidateMode: AutovalidateMode.always,
            child: ExpansionPanelList(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                ref
                    .read(provider(ref).notifier)
                    .expandItem(panelIndex, isExpanded);
              },
              children: state.expandList
                  .mapIndexed(
                    (index, e) => getAssetsInfoExpansionItem(
                      ref,
                      state,
                      e,
                      index,
                    ),
                  )
                  .toList(),
            ),
          ),
          footerWidget(context, ref, state),
        ],
      ),
    );
  }

  Widget headerWidget(BuildContext context, WidgetRef ref, M state) =>
      const SizedBox.shrink();

  Widget footerWidget(BuildContext context, WidgetRef ref, M state) =>
      const SizedBox.shrink();

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    return [
      Row(
        children: [
          Expanded(
            child: CustomButton.danger(
              context,
              title: S.current.huy,
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: CustomButton.primary(
              context,
              title: S.current.luu,
              onPressed: () {
                ref.read(provider(ref).notifier).saveData();
              },
            ),
          ),
        ],
      )
    ];
  }

  ExpansionPanel getAssetsInfoExpansionItem(
    WidgetRef ref,
    M state,
    ExpandModel expandModel,
    int index, {
    bool boldTitle = true,
  }) {
    final expandKey = expandModel.key ?? '';
    if (expandKey.contains(phapLyThucTe)) {
      return getLegalAndFactualInfor(
        ref,
        state,
        expandModel,
        index,
        boldTitle: boldTitle,
      );
    }
    Widget expandBody;
    if (expandModel.child.isNotEmpty) {
      expandBody = ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (panelIndex, isExpanded) {
          ref
              .read(provider(ref).notifier)
              .expandChildItem(index, panelIndex, isExpanded);
        },
        children: expandModel.child
            .mapIndexed(
              (childIndex, element) => getAssetsInfoExpansionItem(
                ref,
                state,
                element,
                childIndex,
                boldTitle: false,
              ),
            )
            .toList(),
      );
    } else {
      expandBody = getExpanBody(expandModel.lsInputField);
    }
    return ExpansionPanel(
      isExpanded: expandModel.isExpand,
      canTapOnHeader: true,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(
          context,
          ref,
          expandModel,
          index,
          boldTitle: boldTitle,
        );
      },
      body: expandBody,
    );
    // return Expanb
  }

  ///Các item thông tin pháp lý và thực tế
  ExpansionPanel getLegalAndFactualInfor(
    WidgetRef ref,
    M state,
    ExpandModel expandModel,
    int index, {
    bool boldTitle = true,
  }) {
    final expandKey = expandModel.key ?? '';
    final expandChild = expandModel.child;
    if (expandChild.isEmpty && expandChild.length < 2) {
      throw Exception('Thông tin pháp lý và thực tế phải có Expand child');
    }
    final legalChild = expandChild[0].lsInputField;
    final factualChild = expandChild[1].lsInputField;
    final totalRow = legalChild.length;
    return ExpansionPanel(
      isExpanded: expandModel.isExpand,
      canTapOnHeader: true,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(
          context,
          ref,
          expandModel,
          index,
          boldTitle: boldTitle,
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...(expandModel.topLsInputField)
              .map<Widget>(
                (e) => inputWidgetFromInputModel(
                  e,
                  nextInfo:
                      expandModel.topLsInputField.elementAtOrNull(index + 1),
                  margin: const EdgeInsets.only(bottom: 8),
                ),
              )
              .toList()
            ..add(
              const SizedBox(
                height: 16,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'HSPL',
                  textAlign: TextAlign.center,
                  style: ref.context.textNormalBold,
                ),
              ),
              IconButton(
                onPressed: () {
                  expandModel.copyLegalToFactual?.call();
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
              ),
              Expanded(
                child: Text(
                  S.current.thuc_te,
                  textAlign: TextAlign.center,
                  style: ref.context.textNormalBold,
                ),
              )
            ],
          ),
          ...List.generate(
            totalRow,
            (index) {
              final legalItem = legalChild[index]..showTitle = false;
              final factualItem = factualChild[index]..showTitle = false;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text.rich(
                        TextSpan(
                          text: legalItem.label ?? '',
                          children: [
                            if (factualItem.isRequired == true)
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                          ],
                          style: ref.context.textNormal.copyWith(
                            color: const Color(0xFF3F547B),
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: inputWidgetFromInputModel(
                            legalItem,
                            nextInfo: legalChild.elementAtOrNull(index + 1),
                            padding: 8,
                          ),
                        ),
                        Expanded(
                          child: inputWidgetFromInputModel(
                            factualItem,
                            nextInfo: factualChild.elementAtOrNull(index + 1),
                            padding: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          getExpanBody(expandModel.lsInputField)
        ],
      ),
    );
  }

  Wrap getExpanBody(List<InputFieldModel> lsInputField) {
    return Wrap(
      runSpacing: 8,
      children: lsInputField
          .mapIndexed<Widget>((index, e) => inputWidgetFromInputModel(e,
              nextInfo: lsInputField.elementAtOrNull(index + 1)))
          .toList()
        ..add(
          const SizedBox(
            height: 16,
          ),
        ),
    );
  }

  CustomInputWidget inputWidgetFromInputModel(
    InputFieldModel e, {
    InputFieldModel? nextInfo,
    double padding = 16,
    EdgeInsets? margin,
  }) {
    return CustomInputWidget(
      margin: margin,
      inputFieldModel: e,
      nextInputModel: nextInfo,
      padding: EdgeInsets.symmetric(horizontal: padding),
    );
  }

  Widget getTitleWidget(
    BuildContext context,
    WidgetRef ref,
    ExpandModel expandModel,
    int index, {
    bool boldTitle = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                expandModel.generateTitleIndex
                    ? '${expandModel.title} ${index + 1}'
                    : expandModel.title,
                style: boldTitle ? context.textMediumBold : context.textMedium,
              ),
            ),
          ),
          if (expandModel.allowDelete)
            IconButton(
              onPressed: () {
                hasEditValue = true;
                expandModel.removeExpandClicked
                    ?.call(context, ref, expandModel.id);
              },
              icon: const Icon(Icons.remove),
            ),
          if (expandModel.allowAdd)
            IconButton(
              onPressed: () {
                hasEditValue = true;
                expandModel.addNewExpandClicked
                    ?.call(context, ref, expandModel.id);
              },
              icon: const Icon(Icons.add),
            ),
          if (expandModel.trailingExpandWidgetBuilder != null)
            expandModel.trailingExpandWidgetBuilder!.call(context, ref)
        ],
      ),
    );
  }
}
