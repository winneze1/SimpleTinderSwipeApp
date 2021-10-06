class ConfigUrl {
  ConfigUrl._privateConstructor();

  static final ConfigUrl _instance = ConfigUrl._privateConstructor();

  static ConfigUrl get instance {
    return _instance;
  }

  String versionNumber = '1.0.0';

  String baseUrl = 'https://dummyapi.io/data/v1';
}
