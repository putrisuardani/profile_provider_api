import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final String baseUrl = 'http://10.148.86.200:5000/profiles';

  List<Profile> _profiles = [];
  List<Profile> get profiles => _profiles;

  Profile _myProfile = Profile(
    id: '',
    name: 'Luh Gede Putri',
    phone: '+6281337136811',
    profilePhoto: 'https://i.pravatar.cc/150?img=25',
    coverPhoto: 'https://picsum.photos/600/200?xrandom=25',
    quote:
        '“Jangan jadi orang lucu karena ujung-ujungnya cuma enak dijadiin temen.”',
  );
  Profile get myProfile => _myProfile;

  void updateMyProfile(Profile profile) {
    _myProfile = profile;
    notifyListeners();
  }

  Future<void> fetchProfiles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _profiles = data.map((json) => Profile.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching profiles: $e');
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profile.toJson()),
      );
      if (response.statusCode == 201) {
        final newProfile = Profile.fromJson(json.decode(response.body));
        _profiles.add(newProfile);
        notifyListeners();
      }
    } catch (e) {
      print('Error adding profile: $e');
    }
  }

  Future<void> updateProfile(String id, Profile updatedProfile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedProfile.toJson()),
    );

    if (response.statusCode == 200) {
      await fetchProfiles(); // refresh data dari server
      notifyListeners();
    } else {
      throw Exception('Gagal update profil');
    }
  }

  Future<void> deleteProfile(String id) async {
    try {
      final url = '$baseUrl/$id';
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        _profiles.removeWhere((p) => p.id == id);
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }
}
