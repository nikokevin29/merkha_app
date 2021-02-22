import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merkha_app/bloc/feed_bloc.dart';
import 'package:merkha_app/view/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/cubit.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
        BlocProvider(create: (_) => FeedrandomCubit()),
        BlocProvider(create: (_) => BestSellerProductCubit()),
        BlocProvider(create: (_) => ProductByCategoryCubit()),
        BlocProvider(create: (_) => MerchantRandomOrderCubit()),
        BlocProvider(create: (_) => SearchProductCubit()),
        BlocProvider(create: (_) => SearchMerchantCubit()),
        BlocProvider(create: (_) => WishlistCubit()),
        BlocProvider(create: (_) => VoucherCubit()),
        BlocProvider(create: (_) => FollowCubit()),
        BlocProvider(create: (_) => FeedCubit()),
        BlocProvider(create: (_) => OwnfeedCubit()),
        BlocProvider(create: (_) => CommentCubit()),
        BlocProvider(create: (_) => MerchantcategoryCubit()),
        BlocProvider(create: (_) => ProductbymerchatcatCubit()),
        BlocProvider(create: (_) => MerchantbyidCubit()),
        BlocProvider(create: (_) => FeedbymerchantidCubit()),
        BlocProvider(create: (_) => ProductbymerchantCubit()),
        BlocProvider(create: (_) => FeedbestsellerCubit()),
        BlocProvider(create: (_) => SearchProductMerchantCubit()),
        BlocProvider(create: (_) => OrderCubit()),
        BlocProvider(create: (_) => OrderFinishCubit()),
        BlocProvider(create: (_) => DetailorderCubit()),
        BlocProvider(create: (_) => FeedbyuseridCubit()),
        BlocProvider(create: (_) => ReviewMerchantCubit()),
        BlocProvider(create: (context) => FeedBloc(httpClient: http.Client())..add(FeedFetched())),
        //TODO:: insert Bloc Here
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
