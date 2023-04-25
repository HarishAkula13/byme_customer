
import 'package:rxdart/rxdart.dart';

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';

typedef BlocProvider<PaymentmethodBloc> PaymentmethodFactory();
class PaymentmethodBloc extends BlocBase {
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  PaymentmethodBloc(this.userDataStore){
    setListeners();
  }

  void setListeners() {}

}