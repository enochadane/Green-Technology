// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/pages/NormalUser/index.dart';
import 'package:flutter_firestore_example/pages/admin/index.dart';
import 'package:flutter_firestore_example/pages/collectors/index.dart';
import 'package:flutter_firestore_example/pages/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore_example/pages/login_screen.dart';
import 'package:flutter_firestore_example/pages/collectors/map.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:flutter_firestore_example/pages/NormalUser/edit_profile_page.dart';
import 'package:flutter_firestore_example/pages/NormalUser/profile.dart';
import 'package:flutter_firestore_example/pages/register_screen.dart';
import 'utils/auth_provider.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    
    late User? user;
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(builder: (context) {
            final user = Provider.of<UserRepository>(context).authenticatedUser;
            final userStatus = Provider.of<UserRepository>(context).status;

            switch (userStatus) {
              case Status.Unauthenticated:
                {
                  return LoginPage();
                }
              case Status.Authenticated:
                {
                  switch (user!.role) {
                    case "NORMAL_USER":
                      {
                        return NormalUserIndexPage();
                      }
                    case "COLLECTOR_USER":
                      {
                        print('Normal User logged');
                        return CollectorIndexPage();
                      }
                    case "ADMIN_USER":
                      {
                        return AdminIndexPage();
                      }
                    default:
                      {
                        return LoginPage();
                      }
                  }
                }
              case Status.Authenticating:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          });
        }
      case MapPage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            final userStatus = Provider.of<UserRepository>(context).status;
            switch (userStatus) {
              case Status.Unauthenticated:
                {
                  return LoginPage();
                }

              case Status.Authenticated:
                return MapPage();

              case Status.Authenticating:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          });
        }
      case ProfilePage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            final userStatus = Provider.of<UserRepository>(context).status;
            switch (userStatus) {
              case Status.Unauthenticated:
                {
                  return LoginPage();
                }

              case Status.Authenticated:
                return ProfilePage();

              case Status.Authenticating:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          });
        }
      case EditProfilePage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            final userStatus = Provider.of<UserRepository>(context).status;
            switch (userStatus) {
              case Status.Unauthenticated:
                {
                  return LoginPage();
                }

              case Status.Authenticated:
                return EditProfilePage();
              case Status.Authenticating:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          });
        }
      case LoginPage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            final userStatus = Provider.of<UserRepository>(context).status;
            switch (userStatus) {
              case Status.Unauthenticated:
                {
                  return LoginPage();
                }

              case Status.Authenticated:
                {
                  switch (Provider.of<UserRepository>(context)
                      .authenticatedUser!
                      .role) {
                    case "NORMAL_USER":
                      {
                        return NormalUserIndexPage();
                      }
                    case "COLLECTOR_USER":
                      {
                        print('Normal User logged');
                        return CollectorIndexPage();
                      }
                    case "ADMIN_USER":
                      {
                        return AdminIndexPage();
                      }
                    default:
                      {
                        return LoginPage();
                      }
                  }
                }
              case Status.Authenticating:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          });
        }
      case SignUpPage.routeName:
        {
          return MaterialPageRoute(builder: (context) => SignUpPage());
        }
    }
    return null;
  }
}
