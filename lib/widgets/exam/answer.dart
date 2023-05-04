import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final int answerId;
  final Function onSelect;
  final int selectedAnswerId;

  const Answer({
    required this.answerText,
    required this.answerId,
    required this.onSelect,
    required this.selectedAnswerId,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = answerId == selectedAnswerId;
    return InkWell(
      onTap: () => onSelect(answerId),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio<int>(
            value: answerId,
            groupValue: selectedAnswerId,
            activeColor: Colors.blue,
            onChanged: (int? value) => isSelected ? onSelect(null) : onSelect(value!),
          ),
          Expanded(
            child: Text(
              answerText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
