import 'package:dating_application/features/onboarding/repository/onboarding_repository.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingRepository _repository;

  OnboardingProvider({required OnboardingRepository repository})
      : _repository = repository;

  //user data
  String _name = '';
  String _bio = '';
  DateTime? _dateOfBirth;
  String _gender = '';
  List<String> _interests = [];
  List<String> _photoes = [];
  bool _locationPermissionGranted = false;

  //getter methods
  String get name => _name;
  String get bio => _bio;
  DateTime? get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  List<String> get interests => _interests;
  List<String> get photoes => _photoes;
  bool get locationPermissionGranted => _locationPermissionGranted;

  //setter with notifier
  //update Name
  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  //update bio
  void updateBio(String bio) {
    _bio = bio;
    notifyListeners();
  }

  //update date of birth
  void updateDateOfBirth(DateTime? dateOfBirth) {
    _dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  //update date of birth
  void updateGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  //update interests
  void toggledInterests(String interests) {
    if (_interests.contains(interests)) {
      _interests.remove(interests);
    } else {
      _interests.add(interests);
    }
    notifyListeners();
  }

  //update photoes
  void addPhotoe(String photoUrl) {
    _photoes.add(photoUrl);
    notifyListeners();
  }

  void removePhoto(String photoUrl) {
    _photoes.remove(photoUrl);
    notifyListeners();
  }

  //update locationPermissionGranted
  void setLocationPermissionGranted(bool granted) {
    _locationPermissionGranted = granted;
    notifyListeners();
  }

  //add all photooes
  void addAllPhotoes(List<String> photoUrl) {
    _photoes.addAll(photoUrl);
    ChangeNotifier();
  }

  //save userdata
  Future<void> saveOnBoardingData() async {
    await _repository.saveUserData({
      'name': _name,
      'bid': _bio,
      'DateOfBirth': _dateOfBirth?.toIso8601String(),
      'gender': _gender,
      'interests': _interests,
      'photoes': _photoes,
      'locationPermissionGranted': _locationPermissionGranted
    });
  }
}
