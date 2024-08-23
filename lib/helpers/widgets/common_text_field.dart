import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.hintStyle,
    required this.textStyle,
    required this.controller,
    required this.onChanged,
    this.undoController,
    this.autofocus = false,
  });

  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final UndoHistoryController? undoController;
  final bool autofocus;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        showCursor: true,
        autofocus: autofocus,
        controller: controller,
        undoController: undoController,
        style: textStyle,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle!.copyWith(color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        onChanged: onChanged,
        // onTap: () => _onTapTextField(context),
        // readOnly: context.read<StatusIconsCubit>().state is ReadOnlyState,
      ),
    );
  }
}
