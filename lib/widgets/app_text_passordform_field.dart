import 'package:flutter/material.dart';
import 'package:matrimonial_ai/authorization/controllers/auth_controller.dart';

class AppTextPasswordFormField extends StatelessWidget {
    AppTextPasswordFormField({
    Key? key,
    this.controller,
    this.authController,
    this.minLines = 1,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.textAlign,
     this.onPressed,
    this.fillColor,
    this.prefixIcon,
    this.border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    this.focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    this.enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    this.disabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    this.validator,
    this.filled = true,
    this.enabled,
    this.showLabel = true,
    this.onSaved,
    this.onTap,
  }) : super(key: key);
   VoidCallback? onPressed;
  final TextEditingController? controller;
  final AuthController? authController;
  final String? hintText;
  final String? labelText;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final bool filled;
  final bool? enabled;
  final bool showLabel;
  final InputBorder border;
  final InputBorder focusedBorder;
  final InputBorder enabledBorder;
  final InputBorder disabledBorder;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Color? fillColor;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: onTap,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: true,
        minLines: minLines,
        maxLines: maxLines ?? minLines,
        maxLength: maxLength,
        autofocus: false,
        enabled: enabled,
        decoration: InputDecoration(
            filled: filled,
            isDense: true,
            suffixIcon: IconButton(icon: Icon(authController!.showPassowrd.value?Icons.visibility:Icons.visibility_off), onPressed:onPressed,),
            hintStyle: const TextStyle(color: Color(0xFF667085),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'outfit'),
            hintText: hintText,
            labelText: showLabel ? (labelText ?? hintText) : null,
            fillColor: fillColor ?? const Color(0xFFFFFFFF),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            border: border,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            prefixIcon: null != prefixIcon ? Icon(prefixIcon) : null),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
