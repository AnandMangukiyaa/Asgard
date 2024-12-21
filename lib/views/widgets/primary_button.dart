part of 'widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final double? fontSize;
  final double? height;
  final double? width;
  final Color color;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final bool isOutlined;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.width,
    this.fontSize,
    this.height,
    this.color = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    required this.onPressed,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize ?? Sizes.s16.h,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
      textColor: isOutlined ? color : Colors.white,
      color: isOutlined ? Colors.white : color,
      elevation: 0,
      padding: padding,
      height: height ?? Sizes.s48.h,
      minWidth: width ?? ScreenUtil().screenWidth,
      highlightElevation: 0,
      disabledElevation: 0,
      disabledTextColor: Colors.grey,
      disabledColor: Colors.grey.shade200,
      shape: StadiumBorder(side: BorderSide(color: color)),
      onPressed: onPressed != null
          ? () {
              FocusScope.of(context).requestFocus(FocusNode());
              onPressed?.call();
            }
          : null,
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String label;
  final Color color;
  final double? fontSize;
  final VoidCallback onPressed;
  final FontWeight? fontWeight;

  const PrimaryTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.fontSize,
    this.fontWeight,
    this.color = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: fontSize ?? Sizes.s16.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: Sizes.s4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s6.h),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
