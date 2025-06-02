import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BookingServiceCardButtons extends StatelessWidget {
  const BookingServiceCardButtons({
    super.key,
    required this.button1Text,
    required this.button2Text,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    this.buttonEnabled = true,
  });

  final String button1Text;
  final String button2Text;
  final void Function()? onButton1Pressed;
  final void Function()? onButton2Pressed;
  final bool buttonEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: buttonEnabled ? onButton1Pressed : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: WColors.containerBorder,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: Text(button1Text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: buttonEnabled ? WColors.onPrimary : WColors.darkGrey, fontWeight: FontWeight.w500))),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: buttonEnabled ? onButton2Pressed : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonEnabled ? WColors.onPrimary : WColors.onPrimaryBackground,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              disabledBackgroundColor: Colors.grey,
            ),
            child: Text(button2Text,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}
