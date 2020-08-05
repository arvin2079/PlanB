import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/dsd_project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class DSDProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<DSDProject>> _projectStreamController = PublishSubject();
  PublishSubject _subject = PublishSubject();

  Stream<List<DSDProject>> get projectStream => _projectStreamController.stream;

  getProjects() async {
    try {
      List<DSDProject> projects = await _repository.getDSDProjects();
      _projectStreamController.sink.add(projects);
    } on MessagedException catch (e) {
      _projectStreamController.addError(e);
    }
  }

  manageUserRequest(int projectId, int cooperId, bool flag) async {
    try {
      await _repository.manageUserRequest(projectId, cooperId, flag);
    } on MessagedException catch (e) {
      _subject.addError(e);
    }
  }

  finishProject(int projectId) async{
    try{
      await _repository.finishProject(projectId);
    } on MessagedException catch (e){
      _subject.addError(e);
    }
  }

  @override
  void dispose() {
    _projectStreamController.close();
    _subject.close();
  }
}

DSDProjectBloc dsdProjectBloc = DSDProjectBloc();
