import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<Project>> _projectStreamController = PublishSubject();
  PublishSubject<String> _errorsStreamController = PublishSubject();

  Stream<List<Project>> get projectStream => _projectStreamController.stream;
  Stream<String> get errorsStream => _errorsStreamController.stream;

  createNewProject(Project requestProject) async{
    try{
      Project project = await _repository.createNewProject(requestProject);
    }
    on MessagedException catch(e){
      _errorsStreamController.sink.add(e.message);
    }
  }

  getProjects() async {
    try{
      List<Project> projects = await _repository.getProjects();
      _projectStreamController.sink.add(projects);
    }
    on MessagedException catch(e){
      _errorsStreamController.sink.add(e.message);
    }
  }

  @override
  void dispose() {
    _errorsStreamController.close();
    _projectStreamController.close();
  }
}
