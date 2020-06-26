import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<Project> _projectStreamController = PublishSubject();

  Stream<Project> get projectStream => _projectStreamController.stream;

  createNewProject(Project requestProject) async{
    try{
      Project project = await _repository.createNewProject(requestProject);
      _projectStreamController.sink.add(project);
    }
    on MessagedException catch(e){

    }
  }

  @override
  void dispose() {
    _projectStreamController.close();
  }
}
