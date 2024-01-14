import 'package:audacity_user/api/api_service.dart';
import 'package:audacity_user/models/user.dart';
import 'package:audacity_user/providers/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockApiService extends Mock implements ApiService {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('UserProvider Tests', () {
    late UserProvider userProvider;
    late MockApiService mockApiService;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockApiService = MockApiService();
      mockSharedPreferences = MockSharedPreferences();
      userProvider = UserProvider(apiService: mockApiService);
    });

    test('fetchUsers success', () async {
      // Arrange
      when(mockApiService.getUsers(offset: 0, limit: 10))
          .thenAnswer((_) async => [User(id: 1, firstName: 'John', lastName: 'Doe', email: '', gender: "", dateOfBirth: '', job: '', city: '', zipcode: '', latitude: 0, profilePicture: '', phone: '', street: '', state: '', country: '', longitude: 0)]);

      // Act
      await userProvider.fetchUsers();

      // Assert
      expect(userProvider.users.length, 1);
      expect(userProvider.users[0].firstName, 'John');
      verify(mockApiService.getUsers(offset: 0, limit: 10)).called(1);
    });

    test('fetchUsers error', () async {
      // Arrange
      when(mockApiService.getUsers(offset: 0, limit: 10)).thenThrow(Exception('Error fetching users'));

      // Act
      // Assert
      expect(() async => await userProvider.fetchUsers(), throwsException);
      verify(mockApiService.getUsers(offset: 0, limit: 10)).called(1);
    });

    test('toggleFavoriteStatus', () async {
      // Arrange
      final user = User(id: 1, firstName: 'John', lastName: 'Doe', email: '', gender: "", dateOfBirth: '', job: '', city: '', zipcode: '', latitude: 0, profilePicture: '', phone: '', street: '', state: '', country: '', longitude: 0);
      when(mockSharedPreferences.getStringList('favorites')).thenReturn([]);
      when(mockSharedPreferences.setStringList('favorites', any)).thenAnswer((_) async => true);

      // Act
      await userProvider.toggleFavoriteStatus(user);

      // Assert
      expect(userProvider.users[0].isFavorite, true);
      verify(mockSharedPreferences.getStringList('favorites')).called(1);
      verify(mockSharedPreferences.setStringList('favorites', ['1'])).called(1);
    });

    // Add more tests as needed
  });
}
