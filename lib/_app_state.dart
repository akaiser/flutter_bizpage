import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  bool _isAtTop = true;
  bool _isIntroVisible = true;

  int _currentSection = 0;
  int _currentSlide = 0;

  bool get isAtTop => _isAtTop;

  bool get isIntroVisible => _isIntroVisible;

  int get currentSection => _currentSection;

  int get currentSlide => _currentSlide;

  set isAtTop(bool value) {
    if (_isAtTop != value) {
      _isAtTop = value;
      notifyListeners();
    }
  }

  set isIntroVisible(bool value) {
    if (_isIntroVisible != value) {
      _isIntroVisible = value;
      notifyListeners();
    }
  }

  set currentSection(int value) {
    if (_currentSection != value) {
      _currentSection = value;
      notifyListeners();
    }
  }

  set currentSlide(int value) {
    if (_currentSlide != value) {
      _currentSlide = value;
      notifyListeners();
    }
  }
}

class AppStateSelector<T> extends Selector<AppState, T> {
  AppStateSelector({
    required super.selector,
    required super.builder,
    super.child,
    super.key,
  });
}

extension BuildContextExt on BuildContext {
  AppState get appState => read();
}
