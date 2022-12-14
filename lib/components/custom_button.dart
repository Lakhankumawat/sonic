import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final bool? leading;
  final VoidCallback onTap;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.textColor,
      this.leading,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator Sign_buttonWidget - INSTANCE
        InkWell(
      onTap: onTap,
      child: Container(
          width: 315,
          height: 58,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(15, 218, 136, 0.3),
                  offset: Offset(0, 2),
                  blurRadius: 4)
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: textColor, fontSize: 20.w),
                ),
                SizedBox(
                  width: 5.h,
                ),
                leading == true
                    ? Icon(
                        FontAwesomeIcons.arrowRight,
                        color: textColor,
                        size: 17,
                      )
                    : const SizedBox(),
              ],
            ),
          )),
    );
  }
}
