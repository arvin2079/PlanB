import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<Project>> _projectStreamController = PublishSubject();
  PublishSubject<List<Project>> _searchedProjectStreamController = PublishSubject();

  Stream<List<Project>> get projectStream => _projectStreamController.stream;
  Stream<List<Project>> get searchedProjectStream => _projectStreamController.stream;

  createNewProject(Project requestProject) async{
    try{
      Project project = await _repository.createNewProject(requestProject);
    }
    on MessagedException catch(e){
      _projectStreamController.addError(e);
    }
  }

  getProjects() async {
    try{
      List<Project> projects = await _repository.getProjects();
      _projectStreamController.sink.add(projects);
    }
    on MessagedException catch(e){
      _projectStreamController.addError(e);
    }
  }

  searchProject(requestedSkills) async {
    try{
      List<Project> projects = await _repository.searchProject(requestedSkills);
      _searchedProjectStreamController.sink.add(projects);
    }
    on MessagedException catch(e){
      _searchedProjectStreamController.addError(e);
    }
  }

  @override
  void dispose() {
    _projectStreamController.close();
    _searchedProjectStreamController.close();
  }
}
