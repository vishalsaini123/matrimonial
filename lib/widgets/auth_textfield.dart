import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final bool? obscure;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  const AuthTextField({
    Key? key,
    required this.hintText,
    this.obscure,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool? obsecure;
  @override
  void initState() {
    if (widget.obscure != null) obsecure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: obsecure ?? false,
          cursorColor: Colors.white,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color(0xff848484)),
            filled: true,
            fillColor: const Color.fromRGBO(43, 43, 43, 1),
          ),
        ),
        if (widget.obscure ?? false)
          GestureDetector(
              onTap: () {
                setState(() {
                  obsecure = !obsecure!;
                });
              },
              child: SvgPicture.asset('assets/svg/eye.svg'))
      ],
    );
  }
}
