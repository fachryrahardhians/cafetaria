import 'package:authentication_repository/authentication_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:cloud_storage/cloud_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockMenuRepository extends Mock implements MenuRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockCloudStorage extends Mock implements CloudStorage {}

class MockSecureStorage extends Mock implements SecureStorage {}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    AuthenticationRepository? authenticationRepository,
    MenuRepository? menuRepository,
    CategoryRepository? categoryRepository,
    CloudStorage? cloudStorage,
    SecureStorage? secureStorage,
  }) async {
    await pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationRepository ?? MockAuthenticationRepository(),
          ),
          RepositoryProvider.value(
            value: menuRepository ?? MockMenuRepository(),
          ),
          RepositoryProvider.value(
            value: categoryRepository ?? MockCategoryRepository(),
          ),
          RepositoryProvider.value(
            value: cloudStorage ?? MockCloudStorage(),
          ),
          RepositoryProvider.value(
            value: secureStorage ?? MockSecureStorage(),
          ),
        ],
        child: MultiBlocProvider(
          providers: const [],
          child: MaterialApp(
            home: widget,
          ),
        ),
      ),
    );
    await pump();
  }
}
