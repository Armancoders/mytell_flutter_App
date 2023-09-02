
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';

class SplashScreenBloc extends Bloc{
  var animationStarted = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startAnimation();
  }

  startAnimation(){
    Future.delayed(const Duration(milliseconds: 500))
          .then((value) => animationStarted.value = true);
  }
}