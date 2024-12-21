part of 'widgets.dart';

class SoicalAuthButton extends StatelessWidget {
  final String imagePath;
  final double? padding;
  final VoidCallback onPressed;

  const SoicalAuthButton({
    Key? key,
    this.padding,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? Sizes.s12.h),
        height: Sizes.s50.h,
        width: Sizes.s50.w,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary10, width: Sizes.s1.h),
        ),
        child: SvgPicture.asset(imagePath),
      ),
    );
  }
}
