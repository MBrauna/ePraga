import 'package:epraga/allFiles.dart';

class EPragaField extends StatefulWidget {
  // Declaração de conteúdos para Campo
  final BorderRadius cornerRadius;
  final double width, height, wordSpacing;
  final Color backgroundColor, accentColor, textColor;
  final String placeholder, fontFamily;
  final FaIcon prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets margin;
  final Duration duration;
  final MaskTextInputFormatter mask;
  final VoidCallback onClickSuffix;
  final TextBaseline textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final FocusNode focusNode;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;
  final TextEditingController controller;
  // Declaração de conteúdos para Campo

  EPragaField(
      {@required this.width,
      @required this.height,
      @required this.prefixIcon,
      @required this.inputType,
      this.controller,
      this.suffixIcon,
      this.mask,
      this.duration = const Duration(milliseconds: 500),
      this.margin = const EdgeInsets.all(10),
      this.obscureText = false,
      this.backgroundColor = const Color(0xff111823),
      this.cornerRadius = const BorderRadius.all(Radius.circular(10)),
      this.textColor = const Color(0xff5c5bb0),
      this.accentColor = Colors.white,
      this.placeholder = "Placeholder",
      this.isShadow = true,
      this.onClickSuffix,
      this.wordSpacing,
      this.textBaseline,
      this.fontFamily,
      this.fontStyle,
      this.fontWeight,
      this.autofocus = false,
      this.autocorrect = false,
      this.focusNode,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted})
      : assert(width != null),
        assert(height != null),
        assert(prefixIcon != null),
        assert(inputType != null);

  @override
  _EPragaField createState() => _EPragaField();
} // class Campo extends StatefulWidget { ... }

class _EPragaField extends State<EPragaField> {
  @override
  Widget build(BuildContext context) {

    return new Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: TextField(
        enabled: widget.enabled,
        keyboardType: widget.inputType,
        controller: widget.controller,
        inputFormatters: (widget.mask == null) ? null : [widget.mask],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon, labelText: widget.placeholder),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap();
          }
        },
        onChanged: (t) {
          widget.onChanged(t);
        },
        onSubmitted: (t) {
          widget.onSubmitted(t);
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _Campo extends State<Campo> { ... }