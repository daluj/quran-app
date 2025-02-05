import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/backend/sqlite/sqlite_manager.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: FlutterFlowTheme.of(context).tertiary,
                child: Center(
                  child: Image.asset(
                    'assets/images/dawn_white.png',
                    width: 250.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          : const NavBarPage(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: FlutterFlowTheme.of(context).tertiary,
                    child: Center(
                      child: Image.asset(
                        'assets/images/dawn_white.png',
                        width: 250.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : const NavBarPage(),
        ),
        FFRoute(
          name: 'Explore',
          path: '/explore',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Explore')
              : ExploreWidget(
                  initialTab: params.getParam(
                    'initialTab',
                    ParamType.int,
                  ),
                ),
        ),
        FFRoute(
          name: 'verses',
          path: '/verses',
          builder: (context, params) => VersesWidget(
            surahVersesList: params.getParam<String>(
              'surahVersesList',
              ParamType.String,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: 'translation',
          path: '/translation',
          builder: (context, params) => const TranslationWidget(),
        ),
        FFRoute(
          name: 'appInfo',
          path: '/appInfo',
          builder: (context, params) => const AppInfoWidget(),
        ),
        FFRoute(
          name: 'Home',
          path: '/home',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Home')
              : const NavBarPage(
                  initialPage: 'Home',
                  page: HomeWidget(),
                ),
        ),
        FFRoute(
          name: 'search',
          path: '/search',
          builder: (context, params) => SearchWidget(
            searchText: params.getParam(
              'searchText',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'reflections',
          path: '/reflections',
          builder: (context, params) => const ReflectionsWidget(),
        ),
        FFRoute(
          name: 'editReflection',
          path: '/editReflection',
          builder: (context, params) => EditReflectionWidget(
            journal: params.getParam<GetJournalsRow>(
              'journal',
              ParamType.SqliteRow,
            ),
          ),
        ),
        FFRoute(
          name: 'duas',
          path: '/duas',
          builder: (context, params) => const DuasWidget(),
        ),
        FFRoute(
          name: 'comments',
          path: '/comments',
          builder: (context, params) => const CommentsWidget(),
        ),
        FFRoute(
          name: 'learnArabic',
          path: '/learnArabic',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'learnArabic')
              : const LearnArabicWidget(),
        ),
        FFRoute(
          name: 'Quran',
          path: '/quran',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Quran')
              : NavBarPage(
                  initialPage: 'Quran',
                  page: QuranWidget(
                    surahId: params.getParam(
                      'surahId',
                      ParamType.int,
                    ),
                    verseId: params.getParam(
                      'verseId',
                      ParamType.int,
                    ),
                  ),
                ),
        ),
        FFRoute(
          name: 'newReflection',
          path: '/newReflection',
          builder: (context, params) => const NewReflectionWidget(),
        ),
        FFRoute(
          name: 'arabicAlphabet',
          path: '/arabicAlphabet',
          builder: (context, params) => const ArabicAlphabetWidget(),
        ),
        FFRoute(
          name: 'editCollection',
          path: '/editCollection',
          builder: (context, params) => EditCollectionWidget(
            collection: params.getParam<GetCollectionsByTypeRow>(
              'collection',
              ParamType.SqliteRow,
            ),
          ),
        ),
        FFRoute(
          name: 'glossary',
          path: '/glossary',
          builder: (context, params) => const GlossaryWidget(),
        ),
        FFRoute(
          name: 'beautifulNames',
          path: '/beautifulNames',
          builder: (context, params) => const BeautifulNamesWidget(),
        ),
        FFRoute(
          name: 'basics',
          path: '/basics',
          builder: (context, params) => const BasicsWidget(),
        ),
        FFRoute(
          name: 'quranicSalat',
          path: '/quranicSalat',
          builder: (context, params) => const QuranicSalatWidget(),
        ),
        FFRoute(
          name: 'quranInitials',
          path: '/quranInitials',
          builder: (context, params) => const QuranInitialsWidget(),
        ),
        FFRoute(
          name: 'verseComments',
          path: '/verseComments',
          builder: (context, params) => VerseCommentsWidget(
            surahId: params.getParam(
              'surahId',
              ParamType.int,
            ),
            verseId: params.getParam(
              'verseId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'bookmarks',
          path: '/bookmarks',
          builder: (context, params) => const BookmarksWidget(),
        ),
        FFRoute(
          name: 'quranDictionary',
          path: '/quranDictionary',
          builder: (context, params) => const QuranDictionaryWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 200),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
