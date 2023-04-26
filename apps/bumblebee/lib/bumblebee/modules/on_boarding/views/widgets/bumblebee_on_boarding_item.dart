import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/models/bumblebee_on_boarding_model.dart';
import 'package:deasy_animation/deasy_animation.dart';

class BumblebeeOnBoardingItem extends StatelessWidget {
  final BumblebeeOnBoardingModel onBoardingModel;

  BumblebeeOnBoardingItem(this.onBoardingModel);

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Container(
          height: DeasySizeConfigUtils.screenHeight! / 3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(onBoardingModel.sliderImageUrl))),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: FadeInAnimation(
            delay: 1,
            child: Text(
              onBoardingModel.sliderHeading,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: DeasySizeConfigUtils.blockVertical * 3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: FadeInAnimation(
            delay: 1,
            child: Text(
              onBoardingModel.sliderSubHeading,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
