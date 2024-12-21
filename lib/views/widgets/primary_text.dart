
part of 'widgets.dart';

class PrimaryText extends StatelessWidget {
  String text ="";
  FontWeight? weight;
  double? size;
  double? spacing;
  Color? color;
  TextAlign? align;
  TextDecoration? decoration;
  Color? decorationColor;
  TextOverflow? overflow;
  PrimaryText(this.text,{this.weight,this.size,this.color,this.align,this.decoration,this.decorationColor,this.overflow,this.spacing,key});

  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: align ?? TextAlign.left,textScaler: TextScaler.linear(1),style:TextStyle(fontWeight: weight ?? FontWeight.w400,fontSize: size ?? Sizes.s12.sp,color: color ?? Colors.black,decoration: decoration,decorationColor: decorationColor,overflow: overflow,letterSpacing:spacing ),);
  }
}
