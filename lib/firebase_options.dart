// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart';
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

  static const  FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDNmSSuYuQNzdvn_-Kd7Adex0NTlTR8xb4',
    appId: '1:684441976990:web:283a68cda833a0406fbb8f',
    messagingSenderId: '684441976990',
    projectId: 'expense-pro-ed2b2',
    authDomain: 'expense-pro-ed2b2.firebaseapp.com',
    storageBucket: 'expense-pro-ed2b2.firebasestorage.app',
    measurementId: 'G-TEX8YT3V3Y',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW1iJErpqawyqpnXOJIuCG6LVvlWmGDJI',
    appId: '1:684441976990:android:f27bb303f7ab6fa16fbb8f',
    messagingSenderId: '684441976990',
    projectId: 'expense-pro-ed2b2',
    storageBucket: 'expense-pro-ed2b2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB08OUKOGT7LU6LaWDCV0jofWv7BA94X3o',
    appId: '1:684441976990:ios:6a76b1f890d882e86fbb8f',
    messagingSenderId: '684441976990',
    projectId: 'expense-pro-ed2b2',
    storageBucket: 'expense-pro-ed2b2.firebasestorage.app',
    iosBundleId: 'com.example.expensePlan',
  );
}
