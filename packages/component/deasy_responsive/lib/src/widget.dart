part of deasy_responsive;

typedef ResponsiveBuilderType = Widget Function(
  BuildContext,
  Orientation,
  DeasyScreenType,
);

class DeasyResponsive extends StatelessWidget {
  const DeasyResponsive({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final ResponsiveBuilderType builder;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 651;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Device.setScreenSize(
          context,
          constraints,
          orientation,
        );

        if (constraints.maxWidth == 0 || constraints.maxHeight == 0) {
          return const SizedBox();
        }
        return builder(context, orientation, Device.screenType);
      });
    });
  }
}
