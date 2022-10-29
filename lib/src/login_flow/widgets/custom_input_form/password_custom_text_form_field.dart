import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/login_flow/widgets/mixins/validations_mixin.dart';

import '../../../../utils/consts.dart';
import 'custom_text_form_field.dart';

class PasswordCustomTextFormField extends StatefulWidget {
  const PasswordCustomTextFormField({
    Key? key,
    required this.password,
    required this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.suffix,
  }) : super(key: key);

  final TextEditingController password;
  final TextInputAction textInputAction;
  final Function(String?)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Widget? suffix;

  @override
  State<PasswordCustomTextFormField> createState() =>
      _PasswordCustomTextFormFieldState();
}

class _PasswordCustomTextFormFieldState
    extends State<PasswordCustomTextFormField> with ValidationMixin {
  bool obscureText = true;

  Widget? get obscureIcon =>
      Icon(obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).primaryColorDark);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: const Icon(Icons.vpn_key),
      obscureText: obscureText,
      label: Consts.textPassword,
      name: widget.password,
      hintText: Consts.textHintTextPassword,
      validator: (value) => validatePassword(value),
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
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
