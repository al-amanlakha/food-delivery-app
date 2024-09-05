import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../utils/utils.dart';
import '../../utils/validator_utils.dart';
import '../buttons/generic_button.dart';
import '../textfield/generic_textfield.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final TextEditingController _cardHolderName = TextEditingController();
  final FocusNode _cardHolderNameNode = FocusNode();
  final TextEditingController _cardNumber = TextEditingController();
  final FocusNode _cardNumberNode = FocusNode();
  final TextEditingController _expiryDate = TextEditingController();
  final FocusNode _expiryDateNode = FocusNode();
  final TextEditingController _cvv = TextEditingController();
  final FocusNode _cvvNode = FocusNode();

  Map<String, String> errors = {
    'name': '',
    'number': '',
    'expiry': '',
    'cvv': '',
  };

  @override
  void initState() {
    super.initState();
    addListenersToControllers();
  }

  void addListenersToControllers() {
    _cardNumber.addListener(() => validateCardNumber());
    _cardHolderName.addListener(() => validateCardName());
    _expiryDate.addListener(() => validateExpiryDate());
    _cvv.addListener(() => validateCVV());
  }

  void validateCardNumber() {
    setState(() {
      errors['number'] = ValidatorUtils.instance.validateCardNumWithLuhAlgorithm(_cardNumber.text);
    });
  }

  void validateCardName() {
    setState(() {
      errors['name'] = ValidatorUtils.instance.validateCardName(_cardHolderName.text);
    });
  }

  void validateExpiryDate() {
    setState(() {
      errors['expiry'] = ValidatorUtils.instance.validateDate(_expiryDate.text);
    });
  }

  void validateCVV() {
    setState(() {
      errors['cvv'] = ValidatorUtils.instance.validateCVV(_cvv.text);
    });
  }

  bool validate() {
    // Validate Card Holder's Name
    if (_cardHolderName.text.trim().isEmpty || errors['name']!.isNotEmpty) {
      _cardHolderNameNode.requestFocus();
      return false;
    }
    // Validate Card Number
    if (_cardNumber.text.trim().isEmpty || errors['number']!.isNotEmpty) {
      _cardNumberNode.requestFocus();
      return false;
    }
    // Validate Expiry Date
    if (_expiryDate.text.trim().isEmpty || errors['expiry']!.isNotEmpty) {
      _expiryDateNode.requestFocus();
      return false;
    }
    // Validate CVV
    if (_cvv.text.trim().isEmpty || errors['cvv']!.isNotEmpty) {
      _cvvNode.requestFocus();
      return false;
    }
    return true;
  }


  @override
  void dispose() {
    _cardHolderName.dispose();
    _cardNumber.dispose();
    _expiryDate.dispose();
    _cvv.dispose();
    _cardHolderNameNode.dispose();
    _cardNumberNode.dispose();
    _expiryDateNode.dispose();
    _cvvNode.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    required String errorKey,
    required String hintText,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextStyles.text2.copyWith(color: AppColors.grey)),
        const SizedBox(height: AppValues.margin4),
        GenericTextField(
          controller: controller,
          focusNode: focusNode,
          errorText: errors[errorKey.toLowerCase()]?.isEmpty ?? true ? null : errors[errorKey.toLowerCase()],
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          hintText: hintText,
          inputFormatters: inputFormatters,
          isObscure: obscureText,
        ),
        defaultHeightSpacing,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.6,
      maxChildSize: 0.8,
      initialChildSize: 0.6,
      shouldCloseOnMinExtent: true,
      builder: (context, scrollController) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.addYourCard, style: AppTextStyles.heading2),
        ),
        body: ListView(
          padding: AppPaddings.defaultPaddingAll,
          controller: scrollController,
          children: [
            buildTextField(
              controller: _cardHolderName,
              focusNode: _cardHolderNameNode,
              errorKey: "name",
              labelText: AppStrings.cardHolderName,
              hintText: AppStrings.cardHolderNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
            ),
            buildTextField(
              controller: _cardNumber,
              focusNode: _cardNumberNode,
              errorKey: "number",
              labelText: AppStrings.cardNumber,
              hintText: AppStrings.cardNumberHint,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    controller: _expiryDate,
                    focusNode: _expiryDateNode,
                    errorKey: "expiry",
                    labelText: AppStrings.expiryDate,
                    hintText: AppStrings.expiryDateHint,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardMonthInputFormatter(),
                    ],
                  ),
                ),
                defaultWidthSpacing,
                Expanded(
                  child: buildTextField(
                    controller: _cvv,
                    focusNode: _cvvNode,
                    errorKey: "cvv",
                    labelText: AppStrings.cvv,
                    hintText: AppStrings.cvvHint,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.defaultPadding, vertical: AppValues.padding10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GenericButton(
                onPressed: () {
                  if(validate()) {

                  }
                },
                title: Text(AppStrings.save, style: AppTextStyles.title.copyWith(color: AppColors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
