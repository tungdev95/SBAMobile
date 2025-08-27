import 'dart:io';

import 'package:grinder/grinder.dart';

Future main(args) => grind(args);

@Task()
Future<void> clean() async {
  await _runProcess(
    'flutter',
    ['clean'],
  );
}

@Task('Build release android')
@Depends(clean, pubGet, format)
Future<void> buildAndroid() async {
  TaskArgs args = context.invocation.arguments;
  String? flavor = args.getOption('flavor');
  String? target = args.getOption('target');
  await buildRunner();
  log("Building Android...");
  await _runProcess('flutter', [
    'build',
    'apk',
    if (flavor != null) ...['--flavor', flavor],
    if (target != null) ...['--target', target]
  ]);
}

@Task('Build IOS')
@Depends(clean, pubGet, format)
Future<void> buildIos() async {
  TaskArgs args = context.invocation.arguments;
  String? flavor = args.getOption('flavor');
  String? target = args.getOption('target');
  await buildRunner();
  log("Building IOS...");
  await _runProcess('flutter', [
    'build',
    'ipa',
    if (flavor != null) ...['--flavor', flavor],
    if (target != null) ...['--target', target]
  ]);
}

@Task('Get packages')
Future<void> pubGet({String? directory}) async {
  await _runProcess(
    'flutter',
    ['pub', 'get', if (directory != null) directory],
  );
}

@Task('Format dart files')
Future<void> format({String path = '.'}) async {
  await _runProcess('flutter', ['format', path]);
}

@Task('Set client')
Future<void> buildClient() async {
  TaskArgs args = context.invocation.arguments;
  String client = args.getOption('client') ?? 'digio';
  await setResource(client);
  await setLanguage(client);
}

@Task('Set resource')
Future<void> setResource(String client) async {
  log('Set client resource to: ${client.toUpperCase()}');
  const symlinkPath = 'assets/main';
  final link = Link(symlinkPath);

  if (link.existsSync() && link.targetSync() == '../assets/$client') {
    return;
  }
  if (link.existsSync()) {
    link.updateSync('../assets/$client');
  } else {
    Link(symlinkPath).createSync('../assets/$client');
  }
}

@Task('Set language')
Future<void> setLanguage(String client) async {
  //l10n
  log('Set client language to: ${client.toUpperCase()}');
  const symlinkPath = 'lib/l10n';
  final link = Link(symlinkPath);

  if (link.existsSync() && link.targetSync() == '../lib/l10n_$client') {
    return;
  }
  if (link.existsSync()) {
    link.updateSync('../lib/l10n_$client');
  } else {
    Link(symlinkPath).createSync('../lib/l10n_$client');
  }
  generateLanguage();
}

Future<void> generateLanguage() async {
  await _runProcess('flutter', ['pub', 'run', 'intl_utils:generate']);
}

Future<void> buildRunner() async {
  log('Build runner');
  await _runProcess('flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs']);
}

Future<void> _runProcess(String executable, List<String> arguments) async {
  final result = await Process.run(executable, arguments);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}
