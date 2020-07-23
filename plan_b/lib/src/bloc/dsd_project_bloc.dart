import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/dsd_project_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class DSDProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<DSDProject>> _dsdProjectStreamController =
      PublishSubject();

  Stream<List<DSDProject>> get dsdProjectStream =>
      _dsdProjectStreamController.stream;

  getProjects() async {
    try {
      List<DSDProject> projects = await _repository.getProjects();
      _dsdProjectStreamController.sink.add(projects);
    } on MessagedException catch (e) {
      _dsdProjectStreamController.addError(e);
    }
  }

  @override
  void dispose() {
    _dsdProjectStreamController.close();
  }
}

DSDProjectBloc dsdProjectBloc = DSDProjectBloc();
