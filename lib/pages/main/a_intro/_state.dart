import 'package:flutter_riverpod/flutter_riverpod.dart';

final atTopProvider = StateProvider<bool>((_) => true);
final introVisibleProvider = StateProvider<bool>((_) => true);
final currentSlideProvider = StateProvider<int>((_) => 0);
