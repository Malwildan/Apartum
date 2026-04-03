import 'package:flutter/foundation.dart';

@immutable
abstract class HomepageEvent {
  const HomepageEvent();
}

class LoadHomepageEvent extends HomepageEvent {
  const LoadHomepageEvent();
}
