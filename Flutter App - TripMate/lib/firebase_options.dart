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
        return macos;
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
    apiKey: 'AIzaSyDRtFUJHjHI3bn5gfgVjd440GzvwsAZlRs',
    appId: '1:40518497691:web:5823143912b1284fc21d3e',
    messagingSenderId: '40518497691',
    projectId: 'traveldb-56c7d',
    authDomain: 'traveldb-56c7d.firebaseapp.com',
    storageBucket: 'traveldb-56c7d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxgFjD4XtwMhTgPYtIyCrtgM4DTtZ1vUs',
    appId: '1:40518497691:android:adb2293ee1be300cc21d3e',
    messagingSenderId: '40518497691',
    projectId: 'traveldb-56c7d',
    storageBucket: 'traveldb-56c7d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrUXfBqh-7bFVxx00sENeUc5NnHBggSls',
    appId: '1:40518497691:ios:e21ab00888cfe136c21d3e',
    messagingSenderId: '40518497691',
    projectId: 'traveldb-56c7d',
    storageBucket: 'traveldb-56c7d.firebasestorage.app',
    iosBundleId: 'com.example.tripmate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrUXfBqh-7bFVxx00sENeUc5NnHBggSls',
    appId: '1:40518497691:ios:e21ab00888cfe136c21d3e',
    messagingSenderId: '40518497691',
    projectId: 'traveldb-56c7d',
    storageBucket: 'traveldb-56c7d.firebasestorage.app',
    iosBundleId: 'com.example.tripmate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRtFUJHjHI3bn5gfgVjd440GzvwsAZlRs',
    appId: '1:40518497691:web:374f413bb101ffb3c21d3e',
    messagingSenderId: '40518497691',
    projectId: 'traveldb-56c7d',
    authDomain: 'traveldb-56c7d.firebaseapp.com',
    storageBucket: 'traveldb-56c7d.firebasestorage.app',
  );
}
