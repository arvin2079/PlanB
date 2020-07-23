import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/dsd_project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class DSDProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<DSDProject>> _projectStreamController =
      PublishSubject();

  Stream<List<DSDProject>> get projectStream =>
      _projectStreamController.stream;

  getProjects() async {
    try {
      List<DSDProject> projects = await _repository.getDSDProjects();
      _projectStreamController.sink.add(projects);
    } on MessagedException catch (e) {
      _projectStreamController.addError(e);
    }
  }

  @override
  void dispose() {
    _projectStreamController.close();
  }
}

DSDProjectBloc dsdProjectBloc = DSDProjectBloc();
