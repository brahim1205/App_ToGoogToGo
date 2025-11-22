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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForWeb',
    appId: '1:123456789:web:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
    authDomain: 'dailycatch-demo.firebaseapp.com',
    storageBucket: 'dailycatch-demo.appspot.com',
    measurementId: 'G-DUMMYID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForAndroid',
    appId: '1:123456789:android:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
    storageBucket: 'dailycatch-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForIOS',
    appId: '1:123456789:ios:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForMacOS',
    appId: '1:123456789:macos:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForWindows',
    appId: '1:123456789:windows:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyDummyApiKeyForLinux',
    appId: '1:123456789:linux:dummyappid',
    messagingSenderId: '123456789',
    projectId: 'dailycatch-demo',
  );
}
