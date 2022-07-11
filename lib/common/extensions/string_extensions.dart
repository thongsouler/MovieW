import 'package:flutter/material.dart';

import '../../presentation/app_localizations.dart';

extension StringExtension on String {
  String intelliTrim() {
    return this.length > 10 ? '${this.substring(0, 10)}...' : this;
  }

  String t(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? '';
  }
}
