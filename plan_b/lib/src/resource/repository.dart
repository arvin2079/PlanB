import 'package:planb/src/model/project_model.dart';
import 'package:planb/src/model/user_model.dart';
import 'package:planb/src/resource/api_provider.dart';

class Repository {

  APIProvider _provider = APIProvider();

  getNewToken(User user) => _provider.signUpNewUser(user);

  login(String username, String password) =>
      _provider.loginUser(username, password);

  getCompleteProfileFields() => _provider.getCompleteProfileFields();

  completeProfile(User user) => _provider.completeProfile(user);

  createNewProject(Project project) => _provider.createNewProject(project);

  getProjects() => _provider.getProjects();

  searchProject(requestedSkills) => _provider.searchProject(requestedSkills);

  searchUser(requestedSkills) => _provider.searchUser(requestedSkills);

  getResume(id) => _provider.getResume(id);

}
