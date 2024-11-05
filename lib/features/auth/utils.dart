import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:uptime/amplifyconfiguration.dart';
import 'package:uptime/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:uptime/ui/layout.dart';

Future<void> signOutCurrentUser() async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    safePrint(e.message);
  }
}

// https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/#initialize-amplify-auth
Future<void> configureAmplify() async {
  if (Amplify.isConfigured) {
    return;
  }

  try {
    await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    safePrint(e);
  }
}

// https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/#initialize-amplify-auth
Future<void> configureTestAmplify() async {
  try {
    await Amplify.addPlugins([AmplifyAPI()]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    safePrint(e);
  }
}

// Customize the Authenticator UI
// https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/#initialize-amplify-auth
Widget? myAuthenticatorBuilder(BuildContext context, AuthenticatorState state) {
  switch (state.currentStep) {
    case AuthenticatorStep.signUp:
      return Scaffold(
          body: Backdrop(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const UptimeBanner(),
                    FormPinner(
                      alignment: Alignment.center,
                      child: SignUpForm(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () => state.changeStep(
                              AuthenticatorStep.signIn,
                            ),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ));

    case AuthenticatorStep.signIn:
      return Scaffold(
        body: FormPinner(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const UptimeBanner(),
              SizedBox(width: 250, child: SignInForm()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signUp,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

    default:
      return null;
  }
}
