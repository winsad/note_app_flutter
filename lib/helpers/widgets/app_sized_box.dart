import 'package:flutter/widgets.dart';

/// A custom SizedBox widget with predefined sizes.
class AppSizedBox extends SizedBox {
  const AppSizedBox({super.key, super.width, super.height});

  /// Large size (24.0 x 24.0)
  factory AppSizedBox.large({Key? key}) {
    return AppSizedBox(key: key, width: 24.0, height: 24.0);
  }

  /// Medium size (16.0 x 16.0)
  factory AppSizedBox.mid({Key? key}) {
    return AppSizedBox(key: key, width: 16.0, height: 16.0);
  }

  /// Small size (8.0 x 8.0)
  factory AppSizedBox.small({Key? key}) {
    return AppSizedBox(key: key, width: 8.0, height: 8.0);
  }

  /// Extra small size (4.0 x 4.0)
  factory AppSizedBox.extraSmall({Key? key}) {
    return AppSizedBox(key: key, width: 4.0, height: 4.0);
  }

  /// Custom size
  factory AppSizedBox.custom({
    Key? key,
    required double width,
    required double height,
  }) {
    return AppSizedBox(key: key, width: width, height: height);
  }
}
