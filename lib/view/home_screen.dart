import 'package:flutter/material.dart';
import 'package:mvvm_project/data/response/status.dart';
import 'package:mvvm_project/utilities/routes/routes_names.dart';
import 'package:mvvm_project/viewModel/home_view_model.dart';
import 'package:mvvm_project/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.fetchUsersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Screen'),
          leading: InkWell(
              onTap: () {
                sharedPreferences.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: const Icon(Icons.logout_outlined)),
        ),
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) {
            return homeViewModel;
          },
          child: Consumer<HomeViewModel>(
              builder: (BuildContext context, value, _) {
            switch (value.usersList.status) {
              case Status.LOADING:
                return const CircularProgressIndicator();
              case Status.ERROR:
                return Text(value.usersList.message.toString());
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.usersList.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              value.usersList.data!.data![index].avatar!),
                        ),
                        title: Text(
                            '${value.usersList.data!.data![index].firstName!} ${value.usersList.data!.data![index].lastName!}'),
                        subtitle: Text(value.usersList.data!.data![index].email
                            .toString()),
                        trailing: Text(
                          value.usersList.data!.data![index].id.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
            return Container();
          }),
        ));
  }
}
