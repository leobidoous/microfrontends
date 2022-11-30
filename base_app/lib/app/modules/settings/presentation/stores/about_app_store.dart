import 'package:core/core.dart';

import '../../../../../app_configuration.dart';

class AboutAppStore extends NotifierStore<Exception, PackageInfoEntity> {
  AboutAppStore()
      : super(
          PackageInfoEntity(
            appName: '',
            name: '',
            version: '',
            buildNumber: '',
            buildSignature: '',
          ),
        );

  Future<void> getDeviceInfo() async {
    setLoading(true);
    await AppConfiguration().getAppInfo().then((value) {
      update(value);
    }).whenComplete(() => setLoading(false));
  }
}
