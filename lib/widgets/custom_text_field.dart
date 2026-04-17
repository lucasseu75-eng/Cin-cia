import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          obscureText: isPassword,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: placeholder,
          ),
        ),
      ],
    );
  }
}
