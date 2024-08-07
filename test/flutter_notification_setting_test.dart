import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notification_setting/flutter_notification_setting.dart';
import 'package:flutter_notification_setting/flutter_notification_setting_platform_interface.dart';
import 'package:flutter_notification_setting/flutter_notification_setting_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNotificationSettingPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNotificationSettingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNotificationSettingPlatform initialPlatform = FlutterNotificationSettingPlatform.instance;

  test('$MethodChannelFlutterNotificationSetting is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNotificationSetting>());
  });

  test('getPlatformVersion', () async {
    FlutterNotificationSetting flutterNotificationSettingPlugin = FlutterNotificationSetting();
    MockFlutterNotificationSettingPlatform fakePlatform = MockFlutterNotificationSettingPlatform();
    FlutterNotificationSettingPlatform.instance = fakePlatform;

    expect(await flutterNotificationSettingPlugin.getPlatformVersion(), '42');
  });
}
