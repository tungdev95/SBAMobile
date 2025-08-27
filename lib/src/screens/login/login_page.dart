import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/login/provider/login_controller.dart';
import 'package:sba/src/screens/login/provider/login_states.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/widget_network_image.dart';
import '../base/base_page.dart';

class LoginPage extends BasePage<LoginController, LoginState> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  String get title => '';

  @override
  Color backgroundColor(BuildContext context) => AppColor.primaryColor;

  @override
  AutoDisposeStateNotifierProvider<LoginController, LoginState> provider(ref) =>
      LoginController.loginStateProvider;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget bodyWidget(
    BuildContext context,
    WidgetRef ref,
    LoginState state,
  ) {
    return Stack(
      children: [
        loginContainer(context, ref, state),
        // Positioned(
        //   right: 0,
        //   top: MediaQuery.of(context).padding.top,
        //   child: IconButton(
        //     onPressed: () {
        //       ref.read(provider(ref).notifier).changeApiUrl();
        //     },
        //     icon: const Icon(
        //       Icons.settings,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget loginContainer(
    BuildContext context,
    WidgetRef ref,
    LoginState state,
  ) {
    final controller = ref.watch(appController);
    final user = controller.userLogin;
    final language = controller.language;
    final validateForm = useState(false);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4397D4),
            Color(0xFF4165B1),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 32,
            ),
            Center(
              child: Assets.images.headerImageLogin.image(
                width: MediaQuery.of(context).size.width * .7,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Hệ thống \nphần mềm thẩm định giá'.toUpperCase(),
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Form(
                key: ref
                    .read(LoginController.loginStateProvider.notifier)
                    .loginFormKey,
                autovalidateMode: validateForm.value
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                ref
                                    .read(LoginController
                                        .loginStateProvider.notifier)
                                    .azureADLogin();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                (states) => Colors.white,
                              )),
                              icon: Assets.images.icMsLogin.image(height: 16),
                              label: Text(
                                S.current.dang_nhap_bang_microsoft,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            if (user == null)
                              const SizedBox.shrink()
                            else
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(provider(ref).notifier)
                                          .clearUserInfo();
                                    },
                                    child: Text(
                                      S.current.dang_nhap_tk_khac,
                                      style: context.textNormalBold.copyWith(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    // const Spacer(),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        return Text(
                          S.current.phien_ban(
                              '${snapshot.data?.version ?? ''}(${snapshot.data?.buildNumber ?? ''})'),
                          style:
                              context.textMedium.copyWith(color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _NormalLoginWidget extends ConsumerWidget {
  const _NormalLoginWidget({
    Key? key,
    // required this.widgetHeight,
  }) : super(key: key);

  // final double widgetHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(LoginController.loginStateProvider);
    return Column(
      children: [
        Assets.images.headerImageLogin.image(
          width: MediaQuery.of(context).size.width * .7,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Hệ thống \nphần mềm thẩm định giá'.toUpperCase(),
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(height: 16),
        _LoginTextField(
          validator: (username) {
            if (username == null || username.isEmpty) {
              return S.current.validate_login_name;
            } else {
              return null;
            }
          },
          hint: S.current.login_name,
          textInputAction: TextInputAction.next,
          leading: Assets.images.icUserSvg.svg(),
          onChanged: (value) {
            // username = value;
          },
          controller: ref
              .watch(LoginController.loginStateProvider.notifier)
              .userNameController,
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}

class _LoggedInWidget extends ConsumerWidget {
  const _LoggedInWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appController).userLogin;
    final parentSize = 100.0;
    final size = parentSize - 16;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFCACFEE).withOpacity(.15),
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xFF2154A6),
              shape: BoxShape.circle,
            ),
            child: RoundedImage(
              url: user?.userAvatar ?? '',
              width: size,
              height: size,
              radius: size / 2,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          S.current.xin_chao,
          style: context.textNormal.copyWith(
            color: Colors.white.withAlpha(
              (255 * .7).toInt(),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          user?.fullName ?? '',
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.hint,
    this.controller,
    this.leading,
    this.textInputAction,
    this.obscureText,
    this.suffix,
  });
  final String? Function(String?) validator;
  final void Function(String) onChanged;
  final String hint;
  final Widget? leading;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: leading,
        ),
        suffixIcon: suffix,
        prefixIconConstraints: const BoxConstraints(maxHeight: 48),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        // username = value;
      },
    );
  }
}
