import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class DropdownButton extends ConsumerWidget {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton();
  }
}
