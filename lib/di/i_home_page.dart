import 'package:byme_app/pages/dashboard/pages/orders_history/bloc/orders_history_bloc.dart';
import 'package:byme_app/pages/payment_method/bloc/payment_method_bloc.dart';
import 'package:byme_app/pages/payment_method/payment_method_page.dart';

import '../app/arch/bloc_provider.dart';
import '../pages/dashboard/pages/cart/bloc/cart_bloc.dart';
import '../pages/dashboard/pages/cart/cart_page.dart';
import '../pages/dashboard/pages/home/bloc/home_bloc.dart';
import '../pages/dashboard/pages/home/home_page.dart';
import '../pages/dashboard/pages/order/bloc/orders_bloc.dart';
import '../pages/dashboard/pages/order/orders_page.dart';
import '../pages/dashboard/pages/orders_history/bloc/order_history_details_bloc.dart';
import '../pages/dashboard/pages/orders_history/order_history_details_page.dart';
import '../pages/dashboard/pages/orders_history/orders_history_page.dart';
import '../pages/dashboard/pages/profile/bloc/profile_bloc.dart';
import '../pages/dashboard/pages/profile/profile_page.dart';
import 'app_injector.dart';

extension HomePageExtension on AppInjector {
  BlocProvider<HomeBloc> get  home => container.get();
  BlocProvider<OrdersBloc> get  orders => container.get();
  ProfileFactory get  profile => container.get();
  OrdersHistoryFactory get  ordersHistory => container.get();
  OrdersHistoryDetailsFactory get  ordersHistoryDetails => container.get();
  CartFactory get  cartPage => container.get();
  PaymentmethodFactory get  paymentMethodPage => container.get();

  registerHomePage(){

    container.registerDependency<BlocProvider<HomeBloc>>(() {
      return BlocProvider<HomeBloc>(
        bloc: HomeBloc(userDataStore),
        child: HomePage(),
      );
    });

    container.registerDependency<BlocProvider<OrdersBloc>>(() {
      return BlocProvider<OrdersBloc>(
        bloc: OrdersBloc(userDataStore),
        child: OrdersPage(),
      );
    });
    container.registerDependency<ProfileFactory>((){
      return(Function() onCallBack)=> BlocProvider<ProfileBloc>(bloc: ProfileBloc(userDataStore,onCallBack), child:  ProfilePage());
    });
    container.registerDependency<OrdersHistoryFactory>((){
      return(Function(int type,int pos) onCallBack)=> BlocProvider<OrdersHistoryBloc>(bloc: OrdersHistoryBloc(userDataStore,onCallBack), child:  OrdersHistoryPage());
    });

    container.registerDependency<OrdersHistoryDetailsFactory>((){
      return(pos,Function(int type) onCallBack)=> BlocProvider<OrdersHistoryDetailsBloc>(bloc: OrdersHistoryDetailsBloc(pos,userDataStore,onCallBack), child:  OrdersHistoryDetailsPage());
    });
    container.registerDependency<CartFactory>((){
      return()=> BlocProvider<CartBloc>(bloc: CartBloc(userDataStore), child: CartPage());
    });
    container.registerDependency<PaymentmethodFactory>((){
      return()=> BlocProvider<PaymentmethodBloc>(bloc: PaymentmethodBloc(userDataStore), child: PaymentmethodPage());
    });
  }

}