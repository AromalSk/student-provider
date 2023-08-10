import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/db/provider.dart';
import 'package:students_add/provider/imageprovider.dart';
import 'package:students_add/screen/home/home_screen.dart';

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  
  runApp(
    const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userProvider(),),
        ChangeNotifierProvider(create: (context) => ImagesProviders(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(  
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen()
      ),
    );
  }
}


