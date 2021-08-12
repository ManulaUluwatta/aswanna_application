
import 'package:aswanna_application/routs.dart';
import 'package:aswanna_application/screens/welcome/welcome_screen.dart';
import 'package:aswanna_application/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application\
  
  @override
  Widget build(BuildContext context) {
    // final _init = Firebase.initializeApp();
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: theme(textTheme),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeContrroller.routeName, 
      routes: routes,
    );
  }
}

class HomeContrroller extends StatefulWidget {
  static String routeName = "/homeController";
  const HomeContrroller({ Key key }) : super(key: key);

  @override
  _HomeContrrollerState createState() => _HomeContrrollerState();
}

class _HomeContrrollerState extends State<HomeContrroller> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorWidget();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return WelcomeScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator() ,);
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("Something went wrong !"),
          ],
        ),
      ),
    );
  }
}


// return MultiProvider(
    //   providers: [
    //     Provider<AuthService>(create: (_) => AuthService(FirebaseAuth.instance),
    //     ),
    //     StreamProvider(
    //       create: (context) => context.read<AuthService>().authStatechanges, 
    //     initialData: null,
    //     ), 
    //   ],
    //   child: MaterialApp(
    //     // home: SplashScreen(),
    //     debugShowCheckedModeBanner: false,
    //     theme: theme(textTheme),
    //      initialRoute: SplashScreen.routeName, 
    //       routes: routes,

    //   ),

    //   );
    // return FutureBuilder(
    //   // future: _init,
    //   builder: (context, snapshot) {
    //   if (snapshot.hasError) {
    //     return ErrorWidget();
    //   } else if (snapshot.hasData) {
    //     return MultiProvider(
    //       providers: [
    //         ChangeNotifierProvider<AuthService>.value(value: AuthService()),
    //         StreamProvider<User?>.value(value: AuthService().user, initialData: null)
    //       ],
    //       child: MaterialApp(
    //         theme: theme(textTheme),
    //         debugShowCheckedModeBanner: false,
            
    //         home: Wrapper()
    //         // initialRoute: SignInScreen.routeName, 
    //         // routes: routes,
            
            
    //       ),
    //     );
    //   } else {
    //     return MaterialApp(
    //       theme: theme(textTheme),
    //       debugShowCheckedModeBanner: false,
    //       initialRoute: SplashScreen.routeName,
    //       routes: routes,
    //     );
    //   }
    // });
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: theme(textTheme),
    //   // home: SplashScreen(),
    //   // home: HomeController(),
    //   initialRoute: SplashScreen.routeName,
    //   // initialRoute: ProfileScreen.routeName,
    //   routes: routes,
    // );