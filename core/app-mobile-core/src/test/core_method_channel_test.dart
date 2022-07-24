import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core_method_channel.dart';

void main() {
  MethodChannelCore platform = MethodChannelCore();
  const MethodChannel channel = MethodChannel('core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
