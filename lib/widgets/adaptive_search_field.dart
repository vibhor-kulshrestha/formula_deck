import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Adaptive search field that uses CupertinoSearchTextField on iOS
class AdaptiveSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const AdaptiveSearchField({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSearchTextField(
        controller: controller,
        placeholder: hintText ?? 'Search formulas...',
        onChanged: onChanged,
        onSuffixTap: controller.text.isNotEmpty ? onClear : null,
        style: const TextStyle(
          fontFamily: '.SF Pro Text',
        ),
      );
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search formulas...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

