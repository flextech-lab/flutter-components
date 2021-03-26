import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInput extends StatefulWidget {
  final String text;
  final String label;
  final String errorText;
  final ValueChanged<String> onChanged;
  final String hintText;
  final Widget icon;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool enabled;
  final bool isPassword;
  final bool autoFocus;
  final FocusNode focusNode;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) validator;
  final ThemeData theme;

  const TextFormInput(
      {Key key,
      this.text,
      this.icon,
      this.autoFocus = false,
      this.isPassword = false,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.minLines = 1,
      this.maxLines = 1,
      this.enabled,
      this.contentPadding,
      this.maxLength,
      this.inputFormatters,
      this.errorText,
      @required this.label,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      @required this.theme,
      this.validator})
      : super(key: key);

  @override
  _TextFormInputState createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  bool focado = false;

  @override
  void initState() {
    focado = widget.autoFocus;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            focado = hasFocus;
          });
        },
        child: TextFormField(
          style: widget.theme.textTheme.headline4
              .copyWith(color: widget.theme.colorScheme.secondary),
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          minLines: widget.minLines, //Normal textInputField will be displayed
          maxLines: widget.maxLines, //
          enabled: widget.enabled, //
          validator: widget.validator,
          obscureText: widget.isPassword,
          controller: widget.controller,
          autofocus: widget.autoFocus,
          textCapitalization: TextCapitalization.words,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.start,
          textInputAction: widget.textInputAction,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              errorText: (this.widget.errorText == null
                  ? null
                  : this.widget.errorText),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.only(left: 20.0, right: 10),
              border: new OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.theme.colorScheme.secondary, width: 1.0),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.theme.colorScheme.secondary, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.theme.colorScheme.primary, width: 1.0),
              ),
              focusColor: Colors.red,
              hintStyle: widget.theme.textTheme.headline1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: widget.theme.colorScheme.secondary),
              hintText: widget.hintText,
              filled: true,
              labelText: widget.label,
              labelStyle: widget.theme.textTheme.headline1.copyWith(
                  fontSize: 15.0,
                  color: (focado
                      ? widget.theme.colorScheme.primary
                      : widget.theme.colorScheme.secondary)),
              suffixIcon: widget.icon,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
