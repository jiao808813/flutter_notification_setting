import { FlutterPlugin, FlutterPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';
import MethodChannel, { MethodCallHandler, MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import MethodCall from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodCall';
import { bundleManager, common, Want } from '@kit.AbilityKit';
import { BusinessError } from "@kit.BasicServicesKit";

/** FlutterNotificationSettingPlugin **/
export default class FlutterNotificationSettingPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "FlutterNotificationSettingPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_notification_setting");
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "openNotificationSettingPage") {
      this.openAppSetting();
      result.success(null);
    } else {
      result.notImplemented()
    }
  }

  async openAppSetting() {
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
    let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);

    let want: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      // 跳转到应用和元服务界面，设置设备权限
      uri: "application_info_entry",
      parameters:{ pushParams: data.name}
    };
    (getContext() as common.UIAbilityContext).startAbility(want).then(() => {

    }).catch((err: BusinessError) => {

    });
  }
}