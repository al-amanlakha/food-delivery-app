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
    apiKey: 'AIzaSyAMumtEqTXjGSlBnSXDJPJehWxnJwRVi3g',
    appId: '1:560241871001:web:52c6e90f8907d55a359008',
    messagingSenderId: '560241871001',
    projectId: 'monkey-meal-food-app',
    authDomain: 'monkey-meal-food-app.firebaseapp.com',
    storageBucket: 'monkey-meal-food-app.appspot.com',
    measurementId: 'G-Z6HY6PEJ3D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBNbEU3SAZx0DNk1v8W2gDFczr6J7t2-I',
    appId: '1:560241871001:android:7e4c0f5ce8f952cc359008',
    messagingSenderId: '560241871001',
    projectId: 'monkey-meal-food-app',
    storageBucket: 'monkey-meal-food-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoxtaLuR0r2TFBEzROQrpmHhqOsDTPgrw',
    appId: '1:355346172285:ios:e782ca0199c1f2ef1fa414',
    messagingSenderId: '355346172285',
    projectId: 'monkey-meal',
    storageBucket: 'monkey-meal.appspot.com',
    iosBundleId: 'com.example.foodDelivery',
  );
}