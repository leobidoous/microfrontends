enum Flavor { dev, hml, prod }

class FlavorConfig {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'APP dev';
      case Flavor.hml:
        return 'APP hml';
      case Flavor.prod:
        return 'APP';
      default:
        return 'APP $appFlavor';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://yahfinances.p.rapidapi.com/api';
      case Flavor.hml:
        return 'https://yahfinances.p.rapidapi.com/api';
      case Flavor.prod:
        return 'https://yahfinances.p.rapidapi.com/api';
      default:
        return 'no baseUrl';
    }
  }
}
