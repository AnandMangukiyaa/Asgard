part of 'widgets.dart';

class DialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClosed;

  const DialogHeader({Key? key, required this.title, this.onClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: Sizes.s18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
      trailing: InkWell(
        onTap: onClosed ??
            () {
              Navigator.pop(context);
            },
        child: Icon(Icons.close, color: Colors.black, size: Sizes.s22.h),
      ),
    );
  }
}
