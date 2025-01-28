// Separate API handler
import 'package:demo/core/api/api_services.dart';
import 'package:demo/features/leaves/leave_approval_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String employeeNumber;
  final ApiService apiService;

  const ProfileScreen({
    Key? key,
    required this.employeeNumber,
    required this.apiService,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final response = await widget.apiService
          .get('/directory/v2/get_update/employee/${widget.employeeNumber}/');

      if (response.statusCode == 200) {
        setState(() {
          profileData = response.data['result'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load profile data')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Rest of the ProfileScreen implementation remains the same
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileData == null
              ? const Center(child: Text('No profile data available'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(profileData!['employeeImage'] ?? ''),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '${profileData!['firstName']} ${profileData!['lastName']}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Email: ${profileData!['officialEmail']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Phone: ${profileData!['phone']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Department: ${profileData!['workInfo']['department']['name']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Designation: ${profileData!['workInfo']['designation']['name']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Work Location: ${profileData!['workInfo']['workLocation']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${profileData!['addressDetails']['currentAddressLine1']}, ${profileData!['addressDetails']['currentCity']}, ${profileData!['addressDetails']['currentState']}, ${profileData!['addressDetails']['currentCountry']} - ${profileData!['addressDetails']['currentPincode']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 25.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LeaveApprovalScreen(),
                              ),
                            );
                          },
                          child: const Text("Check Leave Request"),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
