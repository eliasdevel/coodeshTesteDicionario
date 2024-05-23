// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3PNFIzhV2aSQGpLW3vF7ZcJ5rVBxX0oY',
    appId: '1:185032162327:web:ea40d0ab435fb8e9103052',
    messagingSenderId: '185032162327',
    projectId: 'funnydictionary-10819',
    authDomain: 'funnydictionary-10819.firebaseapp.com',
    storageBucket: 'funnydictionary-10819.appspot.com',
    measurementId: 'G-DL3EQ5J42M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOMlbOmqoKH4lNuS5qUaIbplzNoSLGdro',
    appId: '1:185032162327:android:7ec4cfd098ac2729103052',
    messagingSenderId: '185032162327',
    projectId: 'funnydictionary-10819',
    storageBucket: 'funnydictionary-10819.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNtgrw13oHHZW2EH_UfRSfS652t0HFfKY',
    appId: '1:185032162327:ios:fd15ea176dbc6c12103052',
    messagingSenderId: '185032162327',
    projectId: 'funnydictionary-10819',
    storageBucket: 'funnydictionary-10819.appspot.com',
    iosBundleId: 'com.example.funnyDictionary',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD3PNFIzhV2aSQGpLW3vF7ZcJ5rVBxX0oY',
    appId: '1:185032162327:web:ba3f1c01e47895f8103052',
    messagingSenderId: '185032162327',
    projectId: 'funnydictionary-10819',
    authDomain: 'funnydictionary-10819.firebaseapp.com',
    storageBucket: 'funnydictionary-10819.appspot.com',
    measurementId: 'G-S1BMCDLPSH',
  );
}
