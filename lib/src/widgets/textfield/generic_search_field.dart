import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';

class GenericSearchField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool isDense;
  final bool readOnly;
  final bool isObscure;
  final bool autoFocus;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String hintText;
  final String? labelText;
  final Color? fillColor;
  final TextStyle? style;
  final Color? cursorColor;
  final double? cursorHeight;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const GenericSearchField({
    super.key,
    this.style,
    this.onTap,
    this.suffix,
    this.prefix,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
    this.controller,
    this.cursorColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatters,
    this.cursorHeight,
    this.onEditingComplete,
    required this.hintText,
    this.labelText,
    this.enabled = true,
    this.autoFocus = false,
    this.isDense = false,
    this.readOnly = false,
    this.isObscure = false,
    this.textAlign = TextAlign.left,
    this.fillColor = AppColors.white,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next, this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      cursorColor: cursorColor ?? AppColors.blackishGrey,
      style: style ?? AppTextStyles.text2,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      cursorHeight: cursorHeight,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      focusNode: focusNode,
      textAlign: textAlign,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
        hintText: hintText,
        enabled: true,
        filled: fillColor == null ? false : true,
        fillColor: fillColor,
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        isDense: isDense,
        prefixIcon: InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            AppImages.search,
            fit: BoxFit.contain,
            height: 16,
            width: 24,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 40,
          minHeight: 16,
          minWidth: 40,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppValues.defaultRadius,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppValues.defaultRadius,
          ),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppValues.defaultRadius,
          ),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppValues.defaultRadius,
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
