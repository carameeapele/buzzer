import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectsList extends ConsumerStatefulWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectsListState();
}

class _ProjectsListState extends ConsumerState<ProjectsList> {
  final AuthService _auth = AuthService();

  void addProject(Project project) {}
  void deleteProject(Project project) {}
  void editProject(Project project) {}

  @override
  Widget build(BuildContext context) {
    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.list_alt_rounded,
            size: 50.0,
            color: Colors.grey[300],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'Click + to add a project',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    final projects = ref.watch(projectsFetchProvider);

    return Container(
      child: projects.when(
        data: (List<Project> projects) {
          return projects.isEmpty
              ? defaultScreen
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Project project = projects[index];

                    return Card(
                      elevation: 0.0,
                      color: BuzzerColors.lightGrey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      child: Theme(
                        data: data,
                        child: const ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
                          title: Text('Title'),
                          trailing: Text('Date'),
                        ),
                      ),
                    );
                  },
                );
        },
        error: (Object error, StackTrace? stackTrace) {
          return Column();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }
}
