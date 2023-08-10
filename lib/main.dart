import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './providers/Auth.dart';
import './providers/UserExams.dart';
import './providers/UserExamQuestions.dart';
import './providers/QuestionAnswers.dart';
import './screens/login_screen.dart';
import './screens/authenticate_screen.dart';
import './screens/faragir_screen.dart';
import './screens/exams_overview_screen.dart';
import './screens/profile_screen.dart';
import './screens/exam_screen.dart';
//----------------------------------------------------------------------------------------------------------------

void main() => runApp(MyApp());

//----------------------------------------------------------------------------------------------------------------

class MyApp extends StatelessWidget {
//--------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => UserExams()),
        ChangeNotifierProvider(create: (ctx) => UserExamQuestions()),
        ChangeNotifierProvider(create: (ctx) => QuestionAnswers()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fa'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Exams',
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: Colors.blue[600]),
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'YekanBakh',
          ),
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: auth.isAuth! ? FaragirScreen() : LoginScreen(),
          ),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            AuthenticateScreen.routeName: (ctx) => AuthenticateScreen(),
            FaragirScreen.routeName: (ctx) => FaragirScreen(),
            ExamsOverviewScreen.routeName: (ctx) => const ExamsOverviewScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            ExamScreen.routeName: (ctx) => ExamScreen(),
          },
        ),
      ),
    );
  }
}
