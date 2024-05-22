import 'package:get_it/get_it.dart';
import 'package:raven_assessment/viewModel/token_veiw_model.dart';

final getIt = GetIt.instance;
Future<void> getItGetUp() async {

  ////SERVICE
  ///
  // getIt.registerSingleton<AuthServices>(AuthServices());

  ////ViewModels
  ///
  getIt.registerSingleton<TokenViewModel>(TokenViewModel());
}
