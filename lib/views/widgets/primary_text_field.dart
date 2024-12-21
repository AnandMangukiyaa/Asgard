part of 'widgets.dart';

class PrimaryTextField extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Color? labelColor;
  final String? hintText;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final int maxLine;

  const PrimaryTextField({
    Key? key,
    this.icon,
    required this.labelText,
    this.hintText,
    this.labelColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.validator,
    this.maxLine = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: labelColor ?? AppColors.darkGrey,
            fontSize: Sizes.s12.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextFormField(
          autocorrect: false,
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.s16.sp,
            fontWeight: FontWeight.w400,
          ),
          maxLines: maxLine,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          readOnly: readOnly,
          obscuringCharacter: '*',
          cursorColor: AppColors.primary,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon != null ? Icon(icon) : null,
            enabledBorder: _border(const Color(0xffE0E0E0)),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.red),
            focusedErrorBorder: _border(Colors.red),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder _border(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: Sizes.s1.w),
    );
  }
}
