import 'package:flextech/inputs/formatter/numeric_decimal_formatter.dart';
import 'package:flextech/inputs/formatter/numeric_formatter.dart';
import 'package:flextech/theme/custom_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInput extends StatefulWidget {
  final double numberValue;
  final String label;
  final String errorText;
  final ValueChanged<double> onChanged;
  final String hintText;
  final Widget icon;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool enabled;
  final bool autoFocus;
  final FocusNode focusNode;
  final EdgeInsetsGeometry contentPadding;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final Function onSubmited;
  final int precision;
  final ThemeData theme;

  const NumberInput({
    Key key,
    this.numberValue,
    @required this.label,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.icon,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.enabled,
    this.autoFocus = false,
    @required this.theme,
    this.focusNode,
    this.contentPadding,
    this.textInputAction,
    this.inputFormatters,
    this.onSubmited,
    this.precision = 0,
  }) : super(key: key);

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  bool focado = false;
  String value = "0";

  @override
  void initState() {
    focado = widget.autoFocus;

    NumberFormat f;

    if (widget.precision == 0) {
      f = new NumberFormat("#,###", 'es_PY');
    } else {
      f = new NumberFormat("#,##0.00", 'es_PY');
    }

    if (widget.numberValue == null) {
      value = "";
    } else {
      value = f.format(widget.numberValue);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.theme.colorScheme == null) {
      throw Exception("É necesario implementar o colorSheme no ThemeData");
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            focado = hasFocus;
          });
        },
        child: TextFormField(
          style: this
              .widget
              .theme
              .textTheme
              .headline4
              .copyWith(color: widget.theme.colorScheme.secondary),
          inputFormatters: [
            (widget.precision == 0
                ? NumericFormatter()
                : NumericDecimalFormatter(
                    decimalDigits: widget.precision, locale: "es_PY"))
          ],
          onChanged: (value) {
            double val = 0;

            if (widget.precision == 0) {
              val = double.parse(value.replaceAll(".", ""));
            } else {
              String s = value.replaceAll(".", "");
              value = s.replaceAll(",", ".");
              val = double.parse(value);
            }

            widget.onChanged(val);
          },
          maxLength: widget.maxLength,
          minLines: widget.minLines, //Normal textInputField will be displayed
          maxLines: widget.maxLines, //
          enabled: widget.enabled, //
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.numberWithOptions(signed: false),
          textAlign: TextAlign.end,
          textInputAction: widget.textInputAction,
          initialValue: value,
          onFieldSubmitted: widget.onSubmited,
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
                    color: this.widget.theme.colorScheme.primary, width: 1.0),
              ),
              hintStyle: this.widget.theme.textTheme.headline1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: widget.theme.colorScheme.secondary),
              hintText: widget.hintText,
              filled: true,
              labelText: widget.label,
              labelStyle: this.widget.theme.textTheme.headline1.copyWith(
                  fontSize: 15.0,
                  color: (focado
                      ? this.widget.theme.colorScheme.primary
                      : widget.theme.colorScheme.secondary)),
              suffixIcon: widget.icon,
              fillColor: Colors.white,
              hoverColor: widget.theme.colorScheme.secondary),
        ),
      ),
    );
  }
}
