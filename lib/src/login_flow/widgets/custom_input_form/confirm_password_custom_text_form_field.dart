import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/login_flow/widgets/mixins/validations_mixin.dart';

import '../../../../utils/consts.dart';
import 'custom_text_form_field.dart';

class ConfirmPasswordCustomTextFormField extends StatefulWidget {
  const ConfirmPasswordCustomTextFormField({
    Key? key,
    required this.confirmPassword,
    required this.password,
    required this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.suffix,
  }) : super(key: key);

  final TextEditingController confirmPassword;
  final TextEditingController password;
  final TextInputAction textInputAction;
  final Function(String?)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Widget? suffix;

  @override
  State<ConfirmPasswordCustomTextFormField> createState() =>
      _ConfPasswordCustomTextFormFieldState();
}

class _ConfPasswordCustomTextFormFieldState
    extends State<ConfirmPasswordCustomTextFormField> with ValidationMixin {
  bool obscureText = true;

  Widget? get obscureIcon =>
      Icon(obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).primaryColorDark);
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: const Icon(Icons.vpn_key),
      obscureText: obscureText,
      label: Consts.textConfirmPassword,
      name: widget.confirmPassword,
      hintText: '',
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      validator: (value) =>
          validateConfPassword(value, widget.password.value.text),
      suffix: widget.suffix,
      suffixIcon: InkWell(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: obscureIcon,
      ),
    );
  }
}
