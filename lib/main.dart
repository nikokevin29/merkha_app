import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merkha_app/view/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/cubit.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); //Disable Landscape
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => AddressCubit()),
        BlocProvider(create: (_) => UserInterestCubit()),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => BestSellerProductCubit()),
        BlocProvider(create: (_) => ProductByCategoryCubit()),
        BlocProvider(create: (_) => MerchantRandomOrderCubit()),
        BlocProvider(create: (_) => SearchProductCubit()),
        BlocProvider(create: (_) => SearchMerchantCubit()),
        BlocProvider(create: (_) => WishlistCubit()),

        // BlocProvider(create: (_) => TransactionCubit())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
