import 'package:flutter/material.dart';

Padding inputForm(Function(String?) validasi, {required TextEditingController controller,
required String hintTxt, required String helperTxt, required IconData iconData, bool obscureText = false, Widget? togglePassword, bool readOnly = false, void Function()? onTap, void Function(String)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: SizedBox(
      width: 350,
      child: TextFormField(
        onChanged:onChanged,
        validator: (value) => validasi(value),
        autofocus: true,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintTxt,
          border: const OutlineInputBorder(),
          helperText: helperTxt,
          prefixIcon: Icon(iconData),
          suffixIcon: togglePassword,
        ),
        readOnly: readOnly,
        onTap: onTap,
      ),
    ),
  );
}
