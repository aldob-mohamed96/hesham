
import 'package:hesham/features/presentation/screen/auth/login.dart';
import 'package:hesham/features/presentation/screen/class_school/class_schoo_material.dart';
import 'package:hesham/features/presentation/screen/class_school/class_schoo_show_item.dart';
import 'package:hesham/features/presentation/screen/class_school/land_scap_mode.dart';
import 'package:hesham/features/presentation/screen/home/home_screen.dart';
import 'package:hesham/features/presentation/screen/home/notes.dart';
import '../common/widget/no_route_page.dart';
import 'package:flutter/material.dart';
import '../screen/class_school/class_schoo_screen.dart';
import '../screen/home/add_chat.dart';
import '../screen/home/chat_screen.dart';
import '../screen/maintain_app/maintain_app_screen.dart';
import '../screen/splash/splash_screen.dart';
import 'app_routes.dart';
import 'package:hesham/core/di/dependency_injection.dart' as di;

abstract class AppRouter {
  Route onGenerateRoute(RouteSettings settings);
}

class AppRouterImpl implements AppRouter {
  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splashRoot:
           return _routePage(screen:const SplashScreen(), settings: settings);
     case Routes.loginRoot:
                 di.authLoginModule();
           return _routePage(screen: const LoginScreen(), settings: settings);
     case Routes.notes:
         di.noteModule();
        return _routePage(screen: const NoteScreen(), settings: settings);
      case Routes.homeRoot:
           di.homeModule();
        return _routePage(screen: const HomeScreen(), settings: settings);
      case Routes.classSchool:
           return _routePage(screen: const ClassScreen(), settings: settings);
      case Routes.contact:
        di.contactModule();
        return _routePage(screen: const MaintainScreen(), settings: settings);

      case Routes.addContact:
        di.contactModule();
        return _routePage(screen:  AddMaintainScreen(), settings: settings);

     case Routes.classImageShow:
        return _routePage(screen: const ImageView(), settings: settings);
     case Routes.classPdfShow:
        return _routePage(screen:  PdfViewFile(url: settings.arguments as String), settings: settings);
      case Routes.classScreenShow:
        return _routePage(screen: const ClassScreenShow(), settings: settings);
        case Routes.classScreenMaterialShow:
        return _routePage(screen: const ClassScreenMaterial(), settings: settings);
      case Routes.landScapeScreen:
           return _routePage(screen: const LandScapeModeScreen(), settings: settings);
      case Routes.maintainAppRoot:
           return _routePage(screen: const MaintainAppScreen(), settings: settings);
      default:
           return _routePage(screen: const UnDefinedRoute(), settings: settings);
    }
  }

  MaterialPageRoute _routePage(
      {required Widget screen, RouteSettings? settings}) {
    return MaterialPageRoute(
        builder: (BuildContext context) => screen, settings: settings);
  }
}
