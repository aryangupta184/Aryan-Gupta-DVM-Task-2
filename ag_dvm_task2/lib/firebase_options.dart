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
    apiKey: 'AIzaSyCmuC8PEEpfqapf-EV27NKhDbXqW9nNPb8',
    appId: '1:4488452795:web:d0a9f291ebb19731e8e79e',
    messagingSenderId: '4488452795',
    projectId: 'dvm-task2-ag',
    authDomain: 'dvm-task2-ag.firebaseapp.com',
    storageBucket: 'dvm-task2-ag.appspot.com',
    measurementId: 'G-ZMCR0FMH7Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsq8hCAuqaVuMPGPsnfCGg8LDc04ybTnE',
    appId: '1:4488452795:android:7ba75b8161779f62e8e79e',
    messagingSenderId: '4488452795',
    projectId: 'dvm-task2-ag',
    storageBucket: 'dvm-task2-ag.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaiSj_Tpan5EpRllPev3D912H8MhJclmY',
    appId: '1:4488452795:ios:2e940a3ed82380d9e8e79e',
    messagingSenderId: '4488452795',
    projectId: 'dvm-task2-ag',
    storageBucket: 'dvm-task2-ag.appspot.com',
    iosClientId: '4488452795-dacjnjbifq2predbhcmltaoqm3u70icq.apps.googleusercontent.com',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaiSj_Tpan5EpRllPev3D912H8MhJclmY',
    appId: '1:4488452795:ios:2e940a3ed82380d9e8e79e',
    messagingSenderId: '4488452795',
    projectId: 'dvm-task2-ag',
    storageBucket: 'dvm-task2-ag.appspot.com',
    iosClientId: '4488452795-dacjnjbifq2predbhcmltaoqm3u70icq.apps.googleusercontent.com',
    iosBundleId: 'com.example.test',
  );
}
