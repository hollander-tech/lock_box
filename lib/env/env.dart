import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GOOGLE_CLIENT_ID', obfuscate: true)
  static String googleClientId = _Env.googleClientId;
}