// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:animations/animations.dart';

// import '../../models/login/user_model.dart';
// import '../../screens/base/top_level_provider.dart';
// import '../../screens/login/provider/auth_events.dart';

// class AuthWidget extends ConsumerWidget {
//   const AuthWidget({
//     Key? key,
//     required this.signedInBuilder,
//     required this.nonSignedInBuilder,
//     required this.defaultBuilder,
//   }) : super(key: key);
//   final WidgetBuilder nonSignedInBuilder;
//   final WidgetBuilder signedInBuilder;
//   final WidgetBuilder defaultBuilder;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appState = ref.watch(appProvider);
//     ref.listen<UserModel?>(
//       userProvider,
//       (UserModel? previous, UserModel? next) {
//         if (next != null) {
//           ref
//               .read(sharedPreferencesProvider)
//               .setString('user', jsonEncode(next.toJson()));
//         }

//         var isLoggedIn = next?.isLoggedIn() ?? false;
//         if (!isLoggedIn) {
//           //logged out
//           ref
//               .read(appProvider.notifier)
//               .update((state) => const AppState.unAuthenticate());
//         } else {
//           //next có dữ liệu
//           //logged in
//           ref
//               .read(appProvider.notifier)
//               .update((state) => AppState.authenticated(next));
//         }
//       },
//     );

//     return PageTransitionSwitcher(
//       duration: const Duration(milliseconds: 1000),
//       reverse: appState?.when(
//             initial: () => false,
//             unAuthenticate: () => false,
//             authenticated: (user) => false,
//           ) ??
//           true,
//       transitionBuilder: (
//         Widget child,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//       ) {
//         return SharedAxisTransition(
//           animation: animation,
//           fillColor: Colors.transparent,
//           secondaryAnimation: secondaryAnimation,
//           transitionType: SharedAxisTransitionType.vertical,
//           child: child,
//         );
//       },
//       child: appState?.when(
//             initial: () => defaultBuilder(
//               context,
//             ),
//             unAuthenticate: () => nonSignedInBuilder(
//               context,
//             ),
//             authenticated: (user) => signedInBuilder(
//               context,
//             ),
//           ) ??
//           defaultBuilder(
//             context,
//           ),
//     );
//   }
// }
