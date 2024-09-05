import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../data/model/faq/faq_model.dart';

class FAQEntry extends StatefulWidget {
  final FAQ faq;

  const FAQEntry({super.key, required this.faq,});

  @override
  State<FAQEntry> createState() => _FAQEntryState();
}

class _FAQEntryState extends State<FAQEntry> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: AppColors.white,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(widget.faq.question, style: AppTextStyles.title,),
        subtitle: _isExpanded ? Text(widget.faq.answer, style: AppTextStyles.text2,) : null,
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
        ),
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
      ),
    );
  }
}
