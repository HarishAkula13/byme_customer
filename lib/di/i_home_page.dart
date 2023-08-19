import 'package:byme_app/pages/dashboard/pages/orders_history/bloc/orders_history_bloc.dart';
import 'package:byme_app/pages/payment_method/bloc/payment_method_bloc.dart';
import 'package:byme_app/pages/payment_method/payment_method_page.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';

import '../app/arch/bloc_provider.dart';
import '../pages/dashboard/pages/address/address_list_page.dart';
import '../pages/dashboard/pages/address/bloc/address_list_bloc.dart';
import '../pages/dashboard/pages/address/bloc/change_address_bloc.dart';
import '../pages/dashboard/pages/address/change_address_page.dart';
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
import '../pages/order_details/bloc/order_details_bloc.dart';
import '../pages/order_details/order_details.dart';
import '../pages/track_order/bloc/track_order_bloc.dart';
import '../pages/track_order/track_order.dart';
import '../repositories/login/login_api.dart';
import 'app_injector.dart';

extension HomePageExtension on AppInjector {
  BlocProvider<HomeBloc> get  home => container.get();
  BlocProvider<OrdersBloc> get  orders => container.get();
  ProfileFactory get  profile => container.get();
  OrdersHistoryFactory get  ordersHistory => container.get();
  OrdersHistoryDetailsFactory get  ordersHistoryDetails => container.get();
  BlocProvider<CartBloc> get  cartPage => container.get();
  PaymentmethodFactory get  paymentMethodPage => container.get();
  TrackOrderFactory get  trackOrder => container.get();
  OrdersDetailsFactory get  orderDetails => container.get();
  ChangeAddressFactory get  changeAddress => container.get();
  AddressListFactory get  addressList => container.get();

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
      return(Function() onCallBack)=> BlocProvider<ProfileBloc>(bloc: ProfileBloc(ProfileService(),userDataStore,onCallBack), child:  ProfilePage());
    });
    container.registerDependency<OrdersHistoryFactory>((){
      return(Function(int type,int pos) onCallBack)=> BlocProvider<OrdersHistoryBloc>(bloc: OrdersHistoryBloc(userDataStore,onCallBack), child:  OrdersHistoryPage());
    });

    container.registerDependency<OrdersHistoryDetailsFactory>((){
      return(pos,Function(int type) onCallBack)=> BlocProvider<OrdersHistoryDetailsBloc>(bloc: OrdersHistoryDetailsBloc(pos,userDataStore,onCallBack), child:  OrdersHistoryDetailsPage());
    });

    container.registerDependency<BlocProvider<CartBloc>>(() {
      return BlocProvider<CartBloc>(
        bloc: CartBloc(userDataStore),
        child: CartPage(),
      );
    });

    container.registerDependency<PaymentmethodFactory>((){
      return()=> BlocProvider<PaymentmethodBloc>(bloc: PaymentmethodBloc(userDataStore), child: PaymentmethodPage());
    });

    container.registerDependency<TrackOrderFactory>((){
      return()=> BlocProvider<TrackOrderBloc>(bloc: TrackOrderBloc(userDataStore), child: TrackOrderPage());
    });

    container.registerDependency<OrdersDetailsFactory>((){
      return(type)=> BlocProvider<OrderDetailsBloc>(bloc: OrderDetailsBloc(userDataStore,type), child: OrderDetailsPage());
    });
    container.registerDependency<ChangeAddressFactory>((){
      return()=> BlocProvider<ChangeAddressBloc>(bloc: ChangeAddressBloc(LoginService(),userDataStore), child: ChangeAddressPage());
    });

    container.registerDependency<AddressListFactory>((){
      return()=> BlocProvider<AddressListBloc>(bloc: AddressListBloc(userDataStore), child: AddressListPage());
    });

  }

}