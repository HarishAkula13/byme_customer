
import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/model/dashboard/categories.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/utilities/logger.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/dashboard/menu.dart';


typedef BlocProvider<HomeBloc> HomeFactory();
class HomeBloc extends BlocBase{
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isOnline =BehaviorSubject.seeded(true);
  BehaviorSubject<bool> _isService =BehaviorSubject.seeded(false);
  BehaviorSubject<List<Menu>> _menuList =BehaviorSubject.seeded([]);
  BehaviorSubject<List<Categories>> _categoriesList =BehaviorSubject.seeded([]);
  BehaviorSubject<String> _categorieName =BehaviorSubject.seeded('');
  BehaviorSubject<String> _selectedName =BehaviorSubject.seeded('Construction Works');
  BehaviorSubject<String> _subCate =BehaviorSubject.seeded('Carpentry');
  BehaviorSubject<String> _serviceType =BehaviorSubject.seeded('Pilot Service (Instant)');
  BehaviorSubject<String> _workDes = BehaviorSubject();
  BehaviorSubject<String> _instruction = BehaviorSubject();
  BehaviorSubject<String> _dateTime = BehaviorSubject();
  BehaviorSubject<bool> _valid=BehaviorSubject.seeded(false);
  Stream<String> get serviceType => _serviceType;
  Sink<String> get addServiceType => _serviceType;
  Stream<String> get subCate => _subCate;
  Sink<String> get addSubCate => _subCate;
  Stream<String> get selectedName => _selectedName;
  Sink<String> get addSelectedName => _selectedName;
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get isOnline=> _isOnline;
  Sink<bool> get addIsOnline=> _isOnline;
  Stream<bool> get isService=> _isService;
  Sink<bool> get addIsService=> _isService;
  Stream<String> get categorieName=> _categorieName;
  Sink<String> get addCategorieName=> _categorieName;
  Stream<List<Menu>> get menuList=> _menuList;
  Stream<List<Categories>> get categoriesList=> _categoriesList;
  Sink<List<Categories>> get addCategoriesList=> _categoriesList;
  Sink<String> get addInstruction=> _instruction;
  Sink<String> get addWorkDes=> _workDes;
  Sink<String> get addDateTime => _dateTime;
  Stream<String> get dateTime => _dateTime;
  Stream<bool> get valid => _valid;
  HomeBloc(this.userDataStore){
    setListeners();
  }

  void setListeners() {

    List<Menu> list=[
      Menu(icon: 'assets/images/house.svg',title: 'Household \nChores'),
      Menu(icon: 'assets/images/personal.svg',title: 'Personal \nCare'),
      Menu(icon: 'assets/images/event.svg',title: 'Event \nnManagement'),
      Menu(icon: 'assets/images/Construction.svg',title: 'Construction \nWorks'),
      Menu(icon: 'assets/images/auto.svg',title: 'Automobile \nRepairs'),
      Menu(icon: 'assets/images/electronics.svg',title: 'Electronics \nRepairs'),
      Menu(icon: 'assets/images/taxi.svg',title: 'Taxi & Travel'),
      Menu(icon: 'assets/images/tutor.svg',title: 'Tutor'),
      Menu(icon: 'assets/images/medical.svg',title: 'Medical'),
    ];
    _menuList.add(list);
    List<Categories> categories=[
      Categories(title: 'Maid Service',isClick: false),
      Categories(title: 'Sweeping / Moping / Cleaning',isClick: false),
      Categories(title: 'Room Cleaning',isClick: false),
      Categories(title: 'Moping',isClick: false),
      Categories(title: 'Cooking',isClick: false),
      Categories(title: 'Dish Washing',isClick: false),
      Categories(title: 'Washer man',isClick: false),
      Categories(title: 'Key Making Service',isClick: false),
      Categories(title: 'Duplicate Key',isClick: false),
      Categories(title: 'Lock Opening',isClick: false),
      Categories(title: 'Milk man',isClick: false),
      Categories(title: 'Security Guard',isClick: false),
      Categories(title: 'Watchmen',isClick: false),
      Categories(title: 'Car Driver',isClick: false),

    ];
    _categoriesList.add(categories);


    CombineLatestStream.combine5(_selectedName, _subCate,_serviceType,_workDes,_instruction,
            (String a, String b,String c,String d,String e)
        {
          printLog("data", '${a} ${b} ${c} ${d} ${e}');
          return a.isNotEmpty&&b.isNotEmpty&&c.isNotEmpty&&d.isNotEmpty&&e.isNotEmpty;})
        .listen(_valid.add)
        .addTo(disposeBag);


  }
}