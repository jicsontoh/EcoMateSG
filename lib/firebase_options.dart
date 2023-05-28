// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDdVivylzeDOHpzsNiAwPcgR47bW-igSNk',
    appId: '1:1061875712114:web:b8c0b7652feb86017642eb',
    messagingSenderId: '1061875712114',
    projectId: 'ecomatesg-d7cb4',
    authDomain: 'ecomatesg-d7cb4.firebaseapp.com',
    storageBucket: 'ecomatesg-d7cb4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjBrHya4knf_GNImohHPpPHnVetgFG8oo',
    appId: '1:1061875712114:android:6382501010aa3d167642eb',
    messagingSenderId: '1061875712114',
    projectId: 'ecomatesg-d7cb4',
    storageBucket: 'ecomatesg-d7cb4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAT1M_dmXYFuNcCqzjOhee7uYSvKmDckQ',
    appId: '1:1061875712114:ios:02be1e7bfc39c7cb7642eb',
    messagingSenderId: '1061875712114',
    projectId: 'ecomatesg-d7cb4',
    storageBucket: 'ecomatesg-d7cb4.appspot.com',
    iosBundleId: 'com.example.ecomatesg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAT1M_dmXYFuNcCqzjOhee7uYSvKmDckQ',
    appId: '1:1061875712114:ios:597faad2a04c1a127642eb',
    messagingSenderId: '1061875712114',
    projectId: 'ecomatesg-d7cb4',
    storageBucket: 'ecomatesg-d7cb4.appspot.com',
    iosBundleId: 'com.example.ecomatesg.RunnerTests',
  );
}
