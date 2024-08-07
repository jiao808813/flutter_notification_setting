import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notification_setting/flutter_notification_setting_method_channel.dart';

void main() {
  MethodChannelFlutterNotificationSetting platform = MethodChannelFlutterNotificationSetting();
  const MethodChannel channel = MethodChannel('flutter_notification_setting');

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
