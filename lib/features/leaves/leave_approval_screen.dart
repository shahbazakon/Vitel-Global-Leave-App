// leave_approval_screen.dart
import 'package:demo/core/api/api_services.dart';
import 'package:flutter/material.dart';

class LeaveApprovalScreen extends StatefulWidget {
  const LeaveApprovalScreen({super.key});

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  final ApiService _apiService = ApiService();
  List<LeaveRequest> leaveRequests = [];
  Set<int> selectedLeaveIds = {};
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  Future<void> _fetchLeaveRequests() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _apiService.get('attendance/employee_leave_rules/?page_size=1000');
      final data = (response.data);

      if (data['statusCode'] == 200) {
        setState(() {
          leaveRequests = (data['result']['results'] as List)
              .map((item) => LeaveRequest.fromJson(item))
              .toList();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load leave requests';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateLeaveStatus(String status) async {
    if (selectedLeaveIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one leave request')),
      );
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _apiService.put(
        'attendance/employee_leave_rules/',
        {
          'leave_ids': selectedLeaveIds.join(','),
          'status': status,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data ?? 'Status updated successfully')),
      );

      // Refresh the list
      await _fetchLeaveRequests();
      // Clear selections
      setState(() {
        selectedLeaveIds.clear();
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error updating status: ${e.toString()}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Approval System'),
        actions: [
          if (selectedLeaveIds.isNotEmpty) ...[
            IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: () => _updateLeaveStatus('Approved'),
              tooltip: 'Approve Selected',
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () => _updateLeaveStatus('Rejected'),
              tooltip: 'Reject Selected',
            ),
          ],
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : RefreshIndicator(
                  onRefresh: _fetchLeaveRequests,
                  child: ListView.builder(
                    itemCount: leaveRequests.length,
                    itemBuilder: (context, index) {
                      final request = leaveRequests[index];
                      return LeaveRequestCard(
                        request: request,
                        isSelected: selectedLeaveIds.contains(request.leaveId),
                        onToggleSelection: (selected) {
                          setState(() {
                            if (selected) {
                              selectedLeaveIds.add(request.leaveId);
                            } else {
                              selectedLeaveIds.remove(request.leaveId);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
    );
  }
}

class LeaveRequestCard extends StatelessWidget {
  final LeaveRequest request;
  final bool isSelected;
  final Function(bool) onToggleSelection;

  const LeaveRequestCard({
    super.key,
    required this.request,
    required this.isSelected,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) => onToggleSelection(value ?? false),
        title: Text(request.employeeName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Leave Type: ${request.leaveRuleName}'),
            Text('Status: ${request.status}'),
          ],
        ),
        secondary: _getStatusIcon(request.status),
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'rejected':
        return const Icon(Icons.cancel, color: Colors.red);
      case 'pending':
        return const Icon(Icons.pending, color: Colors.orange);
      default:
        return const Icon(Icons.help);
    }
  }
}

class LeaveRequest {
  final int id;
  final String employeeName;
  final int leaveId;
  final String leaveRuleName;
  final String status;

  LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.leaveId,
    required this.leaveRuleName,
    required this.status,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'],
      employeeName: json['employeeName'],
      leaveId: json['leaveId'],
      leaveRuleName: json['leaveRuleName'],
      status: json['status'],
    );
  }
}
