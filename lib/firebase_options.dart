// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAycdDX1b7RtuMcw1S4qssbfLW_3eIXqHA',
    appId: '1:580854511589:android:030a779e9543791d92610c',
    messagingSenderId: '580854511589',
    projectId: 'socialapplication4-fec31',
    storageBucket: 'socialapplication4-fec31.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC78iSGcmeluHjE1MDMFpxRXRfszCs8ucI',
    appId: '1:580854511589:ios:34a6a0ddfbb67e8192610c',
    messagingSenderId: '580854511589',
    projectId: 'socialapplication4-fec31',
    storageBucket: 'socialapplication4-fec31.appspot.com',
    iosClientId: '580854511589-huqvnff9u33vok1s425pn5jjkffdqh9f.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApplication4',
  );
}
