part of 'enums.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

enum AuthType { email, google, apple, facebook }

Map<int, AuthType> authTypeMap = {
  0: AuthType.email,
  1: AuthType.google,
  2: AuthType.apple,
  3: AuthType.facebook,
};
