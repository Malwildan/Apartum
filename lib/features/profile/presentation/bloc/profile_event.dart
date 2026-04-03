import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  const FetchProfileEvent();
}

class UpdateProfileNameEvent extends ProfileEvent {
  final String name;

  const UpdateProfileNameEvent(this.name);
}
