import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/styles.dart';
import 'package:sba/src/widgets/base/color_schemes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final loadingProvider = StateProvider.autoDispose.family((ref, prop) {
  return false;
});
// final a = StateNotifierProvider.autoDispose.family(ref)

abstract class BasePage<S extends StateNotifier<D>, D>
    extends HookConsumerWidget {
  const BasePage({Key? key}) : super(key: key);

  AutoDisposeStateNotifierProvider<S, D> provider(WidgetRef ref);

  String get title => '';
  List<Widget>? actionWidget(BuildContext context, WidgetRef ref) => null;
  Color backgroundColor(BuildContext context) => AppColor.backgroundColor;
  bool enableBack() => true;
  bool get resizeToAvoidBottomInset => true;
  bool get enableLoading => true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = provider(ref);
    var state = ref.watch(stateProvider);

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: (title.isNotEmpty || titleBuilder(context, ref) != null)
          ? getAppbar(context, ref)
          : null,
      backgroundColor: backgroundColor(context),
      body: Stack(
        children: [
          // notifier.state;
          bodyWidget(context, ref, state),
          if (enableLoading)
            Consumer(
              builder: (context, ref, child) {
                var isLoading = ref.watch(loadingProvider(S.toString()));
                // print(
                //     '${isLoading ? 'Show' : 'Hide'} loading in page ${S.toString()}');
                return isLoading
                    ? const LoadingWidget()
                    : const SizedBox.shrink();
              },
            )
        ],
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar(context, ref),
      floatingActionButton: getFloatingButton(context, ref),
      persistentFooterButtons: persistentFooterButtons(context, ref),
    );
  }

  FloatingActionButtonLocation get floatingActionButtonLocation =>
      FloatingActionButtonLocation.endFloat;

  Widget bodyWidget(BuildContext context, WidgetRef ref, D state);

  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) =>
      null;

  /// Nút back
  Padding leadingAppbarWidget(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          onClickedBack(context, ref);
        },
        splashColor: Colors.white.withAlpha(80),
      ),
    );
  }

  /// Appbar widget
  AppBar getAppbar(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      // leading: leadingAppbarWidget(context, ref),
      title: (title.isEmpty && titleBuilder(context, ref) == null)
          ? null
          : getTitleToolbar(context, ref),
      actions: actionWidget(context, ref),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: defaultBGGradient,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  ///Overide nếu muốn custom title
  Widget? titleBuilder(BuildContext context, WidgetRef ref) => null;

  Widget getTitleToolbar(BuildContext context, WidgetRef ref) {
    if (titleBuilder(context, ref) == null) {
      return Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: context.textTitleBold.copyWith(
          color: Colors.white,
        ),
      );
    } else {
      return titleBuilder(context, ref)!;
    }
  }

  Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) => null;

  Future<bool> onClickedBack(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    return true;
  }

  Widget? getFloatingButton(BuildContext context, WidgetRef ref) {
    return null;
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: SpinKitThreeBounce(
          color: context.colorScheme.primary,
          size: 30,
        ),
      ),
    );
  }
}
