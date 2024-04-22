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
    apiKey: 'AIzaSyDrIkBQZkjgACj4IZlTVg3zr4Zi4HLm4lo',
    appId: '1:682735460855:web:117d8f2cef92447ad5cef2',
    messagingSenderId: '682735460855',
    projectId: 'gezi-6724a',
    authDomain: 'gezi-6724a.firebaseapp.com',
    databaseURL: 'https://gezi-6724a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gezi-6724a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5WbNBlhM8dRLc3hdVaQYnyrScgtrs-lU',
    appId: '1:682735460855:android:0f8734cfbf7f2687d5cef2',
    messagingSenderId: '682735460855',
    projectId: 'gezi-6724a',
    databaseURL: 'https://gezi-6724a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gezi-6724a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-tnktEoC-GisXdwWjNSbVNQIfH-yuc10',
    appId: '1:682735460855:ios:388a25c1e1b6ea32d5cef2',
    messagingSenderId: '682735460855',
    projectId: 'gezi-6724a',
    databaseURL: 'https://gezi-6724a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gezi-6724a.appspot.com',
    androidClientId: '682735460855-8q7jo3metbjgp05r3a3v9k9o6hls3h05.apps.googleusercontent.com',
    iosClientId: '682735460855-u0jdqp201jklp1utallhmd5dv521ohnd.apps.googleusercontent.com',
    iosBundleId: 'com.example.gezi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-tnktEoC-GisXdwWjNSbVNQIfH-yuc10',
    appId: '1:682735460855:ios:13c0457c59bcdf29d5cef2',
    messagingSenderId: '682735460855',
    projectId: 'gezi-6724a',
    databaseURL: 'https://gezi-6724a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gezi-6724a.appspot.com',
    androidClientId: '682735460855-8q7jo3metbjgp05r3a3v9k9o6hls3h05.apps.googleusercontent.com',
    iosClientId: '682735460855-idv99jgnkdvkouajoarrak87mr44bub3.apps.googleusercontent.com',
    iosBundleId: 'com.example.gezi.RunnerTests',
  );
}
