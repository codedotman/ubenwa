class EnvironmentConfiguration {
  static const BASE_API_URL = String.fromEnvironment('BASE_API_URL',
      defaultValue: '');

  static const IS_PRODUCTION =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);
}

enum Flavor { dev, prod, test }
