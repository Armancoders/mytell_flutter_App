import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';

class SplashScreenBloc extends Bloc {
  var animationStarted = false.obs;
  // ignore: unused_field
  // final _sipController = Get.put(SIPBloc(), permanent: true);

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  startAnimation() {
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => animationStarted.value = true);
  }
}
