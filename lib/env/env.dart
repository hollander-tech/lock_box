import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GOOGLE_CLIENT_ID_WEB', obfuscate: true)
  static String googleClientIdWeb = _Env.googleClientIdWeb;
  @EnviedField(varName: 'GOOGLE_CLIENT_ID_IOS', obfuscate: true)
  static String googleClientIdIos = _Env.googleClientIdIos;
  @EnviedField(varName: 'GOOGLE_CLIENT_ID_ANDROID', obfuscate: true)
  static String googleClientIdAndroid = _Env.googleClientIdAndroid;
}