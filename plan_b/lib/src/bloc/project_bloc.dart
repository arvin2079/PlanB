import 'dart:math';

import 'package:planb/src/bloc/bloc.dart';
import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/repository.dart';
import 'package:planb/src/utility/message_exception.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends Bloc {
  Repository _repository = Repository();
  PublishSubject<List<Project>> _projectStreamController = PublishSubject();
  PublishSubject<List<Project>> _searchedProjectStreamController =
      PublishSubject();
  PublishSubject<List<User>> _searchedUserStreamController = PublishSubject();
  PublishSubject<List<User>> _corporateRequests = PublishSubject();

  Stream<List<Project>> get projectStream => _projectStreamController.stream;

  Stream<List<Project>> get searchedProjectStream =>
      _searchedProjectStreamController.stream;

  Stream<List<User>> get searchedUserStream =>
      _searchedUserStreamController.stream;

  Stream<List<User>> get corporateRequestsStream => _corporateRequests.stream;

  createNewProject(Project requestProject) async {
    try {
      Project project = await _repository.createNewProject(requestProject);
    } on MessagedException catch (e) {
      _projectStreamController.addError(e);
    } catch (e){
      _projectStreamController.addError(e);
    }
  }

  getProjects() async {
    try {
      List<Project> projects = await _repository.getProjects();
      _projectStreamController.sink.add(projects);
    } on MessagedException catch (e) {
      _projectStreamController.addError(e);
    } catch (e){
      _projectStreamController.addError(e);
    }
  }

  searchProject(requestedSkills) async {
    try {
      List<Project> projects = await _repository.searchProject(requestedSkills);
      _searchedProjectStreamController.sink.add(projects);
    } on MessagedException catch (e) {
      _searchedProjectStreamController.addError(e);
    }  catch (e){
      _searchedProjectStreamController.addError(e);
    }
  }

  searchUser(requestedSkills) async {
    try {
      List<User> users = await _repository.searchUser(requestedSkills);
      _searchedUserStreamController.sink.add(users);
    } on MessagedException catch (e) {
      _searchedUserStreamController.addError(e);
    }  catch (e){
      _searchedUserStreamController.addError(e);
    }
  }

  corporateRequest(int projectId) async {
    try {
      await _repository.corporateRequest(projectId);
    } on MessagedException catch (e) {
      _corporateRequests.addError(e);
    }  catch (e){
      _corporateRequests.addError(e);
    }
  }

  @override
  void dispose() {
    _projectStreamController.close();
    _searchedProjectStreamController.close();
    _searchedUserStreamController.close();
    _corporateRequests.close();
  }
}
