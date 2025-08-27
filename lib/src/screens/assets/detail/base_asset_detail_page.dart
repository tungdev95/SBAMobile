import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';
import '../../../utils/utils.dart';

final assetsDetailProvider = Provider<AssetsModel>((ref) {
  throw UnimplementedError();
});

abstract class BaseAssetDetailPage<T extends BaseDetailModel,
        C extends BaseAssetDetailPageController<T>>
    extends BasePage<C, AssetsDetailState<T>> {
  final bool allowComplete;
  const BaseAssetDetailPage({Key? key, this.allowComplete = false})
      : super(key: key);

  @override
  Color backgroundColor(BuildContext context) => Colors.white;

  @override
  String get title => 'Chi tiết tài sản';

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, AssetsDetailState<T> state) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelStyle: context.textMedium.copyWith(color: Colors.black),
            unselectedLabelColor: Colors.black,
            labelColor: AppColor.secondaryColor,
            indicatorWeight: 1,
            indicatorColor: AppColor.secondaryColor,
            tabs: const [
              Tab(
                text: 'Thông tin khảo sát',
              ),
              Tab(
                text: 'Hình ảnh / bản đồ',
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                getInfoDetailWidget(context, state, ref),
                // const Placeholder(),
                AssetImagePage<T, C>(provider(ref)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    var state = ref.read(provider(ref));
    return [
      Row(
        children: [
          Expanded(
            child: CustomButton.save(
              onPressed: () {
                ref.read(provider(ref).notifier).save();
              },
            ),
          ),
          if (allowComplete) ...[
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: CustomButton.primary(
                context,
                title: S.current.hoan_thanh,
                onPressed: () {
                  ref.read(provider(ref).notifier).complete();
                },
              ),
            )
          ]
        ],
      )
    ];
  }

  Widget getInfoDetailWidget(
      BuildContext context, AssetsDetailState<T> state, WidgetRef ref) {
    final assets = state.assets ?? [];
    final assetKey = state.assetInfo.keys.toList();
    if (assets.isEmpty) return const SizedBox.shrink();
    final tabController = useTabController(initialLength: assets.length);

    return SingleChildScrollView(
      child: Form(
        key: ref.read(provider(ref).notifier).detailKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpansionPanelList(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                ref.read(provider(ref).notifier).expandChildItem(
                    state.defaultInfoList[panelIndex], isExpanded);
              },
              children: state.defaultInfoList
                  .map((e) => getAssetsInfoExpansionItem(ref, state, e, '', -1))
                  .toList(),
            ),
            HookConsumer(
              builder: (context, ref, child) {
                final tabIndex = useState(0);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: TabBar(
                        controller: tabController,
                        onTap: (index) {
                          tabIndex.value = index;
                        },
                        tabs: assetKey.map((e) => Tab(text: e)).toList(),
                      ),
                    ),
                    getAssetsInfoExpansionList(
                        assetKey[tabIndex.value], ref, state)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///Thông tin chi tiết theo từng mã tài sản
  Widget getAssetsInfoExpansionList(
    String assetKey,
    WidgetRef ref,
    AssetsDetailState<T> state,
  ) {
    final expandList = state.assetInfo[assetKey] ?? [];
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (panelIndex, isExpanded) {
        ref
            .read(provider(ref).notifier)
            .expandChildItem(expandList[panelIndex], isExpanded);
      },
      children: expandList
          .mapIndexed(
            (index, e) => getAssetsInfoExpansionItem(
              ref,
              state,
              e,
              assetKey,
              index,
            ),
          )
          .toList(),
    );
  }

  ExpansionPanel getAssetsInfoExpansionItem(
    WidgetRef ref,
    AssetsDetailState<T> state,
    ExpandModel expandModel,
    String assetKey,
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
          // expandModel.child[panelIndex].isExpand = isExpanded;
          ref.read(provider(ref).notifier).expandChildItem(
                expandModel.child[panelIndex],
                isExpanded,
              );
          // ref.read(provider(ref).notifier).expandChildItem(
          //       assetKey,
          //       index,
          //       panelIndex,
          //       isExpanded,
          //     );
        },
        children: [
          ...expandModel.child
              .mapIndexed(
                (childIndex, element) => getAssetsInfoExpansionItem(
                  ref,
                  state,
                  element,
                  assetKey,
                  childIndex,
                  boldTitle: false,
                ),
              )
              .toList()
        ],
      );
      final lsWidget = <Widget>[];

      //Các widget nằm phía trên các item dropdown
      if (expandModel.topLsInputField.isNotEmpty) {
        lsWidget.add(
          getExpanBody(expandModel.topLsInputField),
        );
      }

      //Các widget dropdown
      lsWidget.add(expandBody);

      //Các widget nằm dưới các item dropdown
      if (expandModel.lsInputField.isNotEmpty) {
        lsWidget.add(
          getExpanBody(expandModel.lsInputField),
        );
        expandBody = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            expandBody,
            getExpanBody(expandModel.lsInputField),
          ],
        );
      }

      expandBody = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: lsWidget,
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
  }

  ///Các item thông tin pháp lý và thực tế
  ExpansionPanel getLegalAndFactualInfor(
    WidgetRef ref,
    AssetsDetailState<T> state,
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
    if (legalChild.length != factualChild.length) {
      throw Exception('Thông tin pháp lý và Thực tế phải có cùng độ dài');
    }
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
              .mapIndexed(
                (index, e) => inputWidgetFromInputModel(
                  e,
                  nextInfo:
                      expandModel.topLsInputField.elementAtOrNull(index + 1),
                  margin: const EdgeInsets.only(bottom: 8),
                ),
              )
              .toList(),
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
                          text: factualItem.label ?? '',
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
                expandModel.addNewExpandClicked?.call(
                  context,
                  ref,
                  expandModel.id,
                );
              },
              icon: const Icon(Icons.add),
            ),
          expandModel.trailingExpandWidgetBuilder?.call(context, ref) ??
              const SizedBox.shrink()
        ],
      ),
    );
  }

  List<Override> scopeOverrideByAsset(
      String assetKey, AssetsDetailState<T> state) {
    return [
      // selectedAddressProvider.overrideWithProvider((argument) => null)
    ];
  }

  @override
  Future<bool> onClickedBack(BuildContext context, WidgetRef ref) async {
    if (hasEditValue) {
      final rs = await showOkCancelAlertDialog(
        context: context,
        title: S.current.thong_bao,
        message: 'Dữ liệu chưa được lưu, bạn có chắc muốn thoát không?',
      );
      if (rs == OkCancelResult.ok) {
        return super.onClickedBack(context, ref);
      }
    } else {
      Navigator.maybePop(context);
    }
    return true;
  }
}
