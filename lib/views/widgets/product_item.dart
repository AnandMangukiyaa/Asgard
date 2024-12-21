part of 'widgets.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              imageUrl: product.imageUrl!,
              height: Sizes.s100.h,
              width: Sizes.s100.w,
              radius: Sizes.s12.w,
            ),
            SizedBox(width: Sizes.s16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    product.title!,

                      size: Sizes.s18.sp,
                      weight: FontWeight.bold,

                  ),
                  SizedBox(height: Sizes.s8.h),
                  PrimaryText(
                    product.body!,
                      size: Sizes.s14.sp,
                      color: Colors.grey[700],
                  ),
                  SizedBox(height: Sizes.s8.h),
                  PrimaryText(
                    'Distance: ${product.distance!.toStringAsFixed(2)} km',
                      size: Sizes.s12.sp,
                      color: Colors.grey[500],
                  ),
                  SizedBox(height: Sizes.s8.h),
                  PrimaryButton(label: "View Direction", onPressed: (){
                    Navigator.pushNamed(context, Routes.direction, arguments: product);
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}