import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({super.key});

  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  final NotificationService _notificationService = NotificationService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _showSimpleNotification() async {
    await _notificationService.showNotification(
      title: 'Hello!',
      body: 'This is a simple notification',
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification sent!')),
      );
    }
  }

  Future<void> _showLoginSuccessNotification() async {
    await _notificationService.showLoginSuccessNotification(
      username: 'demo_user',
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login notification sent!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 10.5 - Local Notifications'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: _isInitialized
          ? ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.notifications_active,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(height: 24),
                Text(
                  'Local Notifications Demo',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildNotificationCard(
                  title: 'Simple Notification',
                  description: 'Show a basic notification with title and body',
                  icon: Icons.notifications,
                  color: Colors.blue,
                  onTap: _showSimpleNotification,
                ),
                _buildNotificationCard(
                  title: 'Login Success Notification',
                  description: 'Simulate notification after successful login',
                  icon: Icons.login,
                  color: Colors.green,
                  onTap: _showLoginSuccessNotification,
                ),
                const SizedBox(height: 32),
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Implementation Notes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Notifications require permission on Android 13+\n'
                          '• Uses flutter_local_notifications package\n'
                          '• Integrated in Lab10_Full after login success\n'
                          '• Can be customized with icons, sounds, actions',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.send,
                color: color,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
