part of 'app_dialogs.dart';

class ProductDetailDialog extends StatelessWidget {
  final Product product;

  static Future<bool?> show(BuildContext context,Product product) async {
    return await showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AnimatedSize(
          duration: Duration(milliseconds: 5000),
          child: Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s16.w),
            ),
            child: ProductDetailDialog(product: product),
          ),
        );
      },
    );
  }

  const ProductDetailDialog({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes.s16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageView(imageUrl: product.imageUrl!, height: Sizes.s150.w, width: Sizes.s150.w, radius: Sizes.s12.w),
          SizedBox(height: Sizes.s16.w),
          PrimaryText(
              product.title!,
            size: 20, weight: FontWeight.bold
          ),
          SizedBox(height: Sizes.s8.w),
          PrimaryText(
            product.body!,
            align: TextAlign.center,
          ),
          SizedBox(height: Sizes.s16.w),
          PrimaryButton(label: "View Direction", onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(navigatorKey.currentContext!, Routes.direction, arguments: product);
          })
        ],
      ),
    );
  }
}