import 'package:audacity_user/pages/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Fetch initial users
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _userProvider.fetchUsers();
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 200.0) {
      // Reached the end of the list - fetch more users
      _userProvider.fetchUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of User'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final displayedUsers = userProvider.users;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: displayedUsers.length + (userProvider.isLoading ? 1 : 0),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index < displayedUsers.length) {
                      final user = displayedUsers[index];
                      return ListTile(
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.email),
                        trailing: IconButton(
                          icon: Icon(
                            user.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: user.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () async {
                            // Toggle the favorite status in the provider
                            await _userProvider.toggleFavoriteStatus(user);
                            setState(() {
                              user.isFavorite = !user.isFavorite;
                            });
                          },
                        ),
                        onTap: () {
                          // Navigate to the user details page when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailPage(user: user),
                            ),
                          );
                        },
                      );
                    } else if (userProvider.isLoading) {
                      // Loading indicator at the end of the list
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // Placeholder for the end of the list
                      return SizedBox(height: 100); // Adjust height as needed
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _userProvider.page > 1
                        ? () {
                      _userProvider.page--;
                      int offset = (_userProvider.page - 1) * 10;
                      int limit = _userProvider.page * 10;
                      _userProvider.fetchUsers(offset: offset, limit: limit);
                      _userProvider.users = [];
                    }
                        : null,
                    child: Text('Previous'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _userProvider.page++;
                      int offset = (_userProvider.page - 1) * 10;
                      int limit = _userProvider.page * 10;
                      _userProvider.fetchUsers(offset: offset, limit: limit);
                      _userProvider.users = [];
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}


