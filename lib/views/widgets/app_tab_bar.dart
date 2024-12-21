part of 'widgets.dart';

class AppTabBar extends StatelessWidget {
  final int initialIndex;
  final Map<int, String> tabs;
  final ValueChanged<int>? onTabChanged;
  final List<BoxShadow>? boxShadow;

  const AppTabBar({
    Key? key,
    required this.initialIndex,
    required this.tabs,
    this.onTabChanged,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Container(
        height: ScreenUtil().setHeight(40),
        width: ScreenUtil().setWidth(210),
        padding: EdgeInsets.all(Sizes.s4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.s8.h),
          boxShadow: boxShadow ??
              [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: TabBar(
          onTap: onTabChanged,
          labelColor: Colors.white,
          physics: const NeverScrollableScrollPhysics(),
          unselectedLabelColor: AppColors.darkGrey,
          labelStyle: TextStyle(
            fontSize: Sizes.s14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: AppFontFamily.poppins,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: Sizes.s14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: AppFontFamily.poppins,
          ),
          indicator: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(Sizes.s6.h),
          ),
          tabs: tabs.entries.map((e) {
            return Tab(text: e.value);
          }).toList(),
        ),
      ),
    );
  }
}

class LinerTabBar extends StatelessWidget {
  final Map<int, String> tabs;
  final ValueChanged<int>? onTabChanged;

  const LinerTabBar({Key? key, required this.tabs, this.onTabChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTabChanged,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      physics: const NeverScrollableScrollPhysics(),
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.darkGrey,
      indicatorColor: AppColors.primary,
      labelStyle: TextStyle(
        fontSize: Sizes.s16.sp,
        fontFamily: AppFontFamily.poppins,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Sizes.s16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: AppFontFamily.poppins,
      ),
      tabs: tabs.entries.map((e) {
        return Tab(text: e.value);
      }).toList(),
    );
  }
}
