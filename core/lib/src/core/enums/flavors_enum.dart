enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Gen dev';
      case Flavor.prod:
        return 'Gen';
      default:
        return 'Gen $appFlavor';
    }
  }
}
