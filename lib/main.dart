import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/utils/routes/routes.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view/login_view.dart';
import 'package:provider_mvvm/view_model/auth_view_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        

        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueAccent)),
        initialRoute: RoutesName.login,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
