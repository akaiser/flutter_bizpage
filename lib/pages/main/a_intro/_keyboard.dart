import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Keyboard extends StatelessWidget {
  Keyboard({
    required void Function(KeyType keyType) onKeyPress,
    required this.child,
    Key? key,
  })  : actions = {
          _DirectionIntent: CallbackAction<_DirectionIntent>(
            onInvoke: (intent) => onKeyPress(intent.keyType),
          )
        },
        shortcuts = {
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const _DirectionIntent.backward(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const _DirectionIntent.forward(),
        },
        super(key: key);

  final focusNode = FocusNode();

  final Map<Type, Action<Intent>> actions;
  final Map<LogicalKeySet, _DirectionIntent> shortcuts;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      child: FocusableActionDetector(
        focusNode: focusNode,
        autofocus: true,
        shortcuts: shortcuts,
        actions: actions,
        child: child,
      ),
    );
  }
}

enum KeyType { left, right }

// read: https://medium.com/flutter-community/flutter-keyboard-mouse-support-for-web-36d96a17324a
class _DirectionIntent extends Intent {
  const _DirectionIntent(this.keyType);

  const _DirectionIntent.backward() : keyType = KeyType.left;

  const _DirectionIntent.forward() : keyType = KeyType.right;
  final KeyType keyType;
}
