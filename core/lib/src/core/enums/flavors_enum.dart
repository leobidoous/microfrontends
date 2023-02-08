enum Flavor { dev, hml, prod }

class FlavorConfig {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Plataforma do Boi dev';
      case Flavor.hml:
        return 'Plataforma do Boi hml';
      case Flavor.prod:
        return 'Plataforma do Boi';
      default:
        return 'Plataforma do Boi $appFlavor';
    }
  }
}
