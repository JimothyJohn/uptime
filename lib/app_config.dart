class AppConfig {
  final bool debug;
  final String stripePublishableKey;

  AppConfig({required this.debug, required this.stripePublishableKey});
}

late AppConfig config;

Future<void> getConfig() async {
  const String env = String.fromEnvironment('USER_BRANCH');
  if (env == "test") {
    config = AppConfig(
      stripePublishableKey:
          const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY_TEST'),
      debug: false,
    );
  }
  if (env == "dev") {
    config = AppConfig(
      stripePublishableKey:
          const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY_TEST'),
      debug: true,
    );
  }
  if (env == "main") {
    config = AppConfig(
      stripePublishableKey:
          const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY'),
      debug: false,
    );
  }
  config = AppConfig(
    stripePublishableKey: "",
    debug: true,
  );
}
