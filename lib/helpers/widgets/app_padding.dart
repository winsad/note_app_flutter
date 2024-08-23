import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A custom Padding widget with predefined padding sizes.
class AppPadding extends Padding {
  const AppPadding({
    super.key,
    required EdgeInsets super.padding,
    required Widget super.child,
  });

  /// Large padding (24.0)
  factory AppPadding.large({Key? key, required Widget child}) =>
      AppPadding(key: key, padding: const EdgeInsets.all(24.0), child: child);

  /// Medium padding (16.0)
  factory AppPadding.mid({Key? key, required Widget child}) =>
      AppPadding(key: key, padding: const EdgeInsets.all(16.0), child: child);

  /// Small padding (8.0)
  factory AppPadding.small({Key? key, required Widget child}) =>
      AppPadding(key: key, padding: const EdgeInsets.all(8.0), child: child);

  /// Extra small padding (4.0)
  factory AppPadding.extraSmall({Key? key, required Widget child}) =>
      AppPadding(key: key, padding: const EdgeInsets.all(4.0), child: child);

  /// Custom padding
  factory AppPadding.custom({
    Key? key,
    required double padding,
    required Widget child,
  }) =>
      AppPadding(key: key, padding: EdgeInsets.all(padding), child: child);
}
