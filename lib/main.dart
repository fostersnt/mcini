import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/bloc/movies/movie_bloc.dart';
import 'package:mcini/data/provider/movie_provider.dart';
import 'package:mcini/data/repository/movie_repository.dart';
import 'package:mcini/screens/home/home_swipper.dart';
import 'package:mcini/screens/login/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> myImages = [
      'lib/assets/images/banner.png',
      'lib/assets/images/banner.png',
      'lib/assets/images/banner.png',
    ];
    return RepositoryProvider(
      create: (context) => MovieRepository(movieProvider: MovieProvider()),
      child: BlocProvider(
        create: (context) => MovieBloc(
          movieRepository: MovieRepository(movieProvider: MovieProvider()),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // routes: getRoutes(),
          //Device preview settings
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Mcini Mobile',
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.amber,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // useMaterial3: true,
          ),
          // home: const HomeSlider(),
          // home: const MoviePlayerPage(),
          // home: const MovieCategoriesGroup(),
          home: Scaffold(
              backgroundColor: AppColors.blackColor,
              body: HomeSwipper(images: myImages)),
          // body: const LoginPage(),
          // body: null,
          // bottomNavigationBar: CustomNavigationBar(),
        ),
        // initialRoute: '/',
      ),
    );
  }
}
