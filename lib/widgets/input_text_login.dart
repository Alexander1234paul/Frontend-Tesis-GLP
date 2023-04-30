import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final TextInputType textInputType;
  final double size;
  final ValueChanged<String>? onChange;
  final bool? enabled;
  final VoidCallback? onTap;

  const InputText({
    Key? key,
    required this.label,
    required this.textInputType,
    required this.size,
    this.onChange,
    this.enabled,
    this.onTap,
  }) : super(key: key);

  @override
  State<InputText> createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  late final TextEditingController _controller;

  String? get value => _controller.text;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onTap: widget.onTap,
      keyboardType: widget.textInputType,
      enabled: widget.enabled,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        hintText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize:
              widget.size * 0.04, // Acceder a la propiedad size de InputText
        ),
      ),
    );
  }
}
