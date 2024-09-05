import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';

class GenericTextField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool isDense;
  final bool readOnly;
  final bool isObscure;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String hintText;
  final String? labelText;
  final String? errorText;
  final Color? fillColor;
  final TextStyle? style;
  final Color? cursorColor;
  final double? cursorHeight;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const GenericTextField({
    super.key,
    this.style,
    this.onTap,
    this.suffix,
    this.prefix,
    this.onSaved,
    this.suffixIcon,
    this.focusNode,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.controller,
    this.cursorColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.cursorHeight,
    this.onEditingComplete,
    required this.hintText,
    this.errorText,
    this.labelText,
    this.enabled = true,
    this.isDense = false,
    this.readOnly = false,
    this.isObscure = false,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autoValidateMode = AutovalidateMode.onUserInteraction, this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor ?? AppColors.blackishGrey,
      style: style ?? AppTextStyles.text2,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      cursorHeight: cursorHeight,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      focusNode: focusNode,
      validator: validator,
      textAlign: textAlign,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: labelText != null
            ? Text(
                labelText!,
                style: AppTextStyles.text2.copyWith(
                  color: AppColors.grey,
                ),
              )
            : null,
        hintStyle: AppTextStyles.text2.copyWith(
          color: AppColors.grey,
        ),
        contentPadding: contentPadding ?? AppPaddings.defaultPaddingHorizontal,
        hintText: hintText,
        enabled: true,
        filled: fillColor == null ? false : true,
        fillColor: fillColor,
        suffix: suffix,
        error: errorText != null
            ? Text(
                errorText!,
                style: AppTextStyles.text2.copyWith(color: AppColors.warningRed),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        suffixIcon: suffixIcon,
        prefix: prefix,
        isDense: isDense,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.warningRed,
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.warningRed,
            width: 1,
          ),
        ),
      ),
    );
  }
}
