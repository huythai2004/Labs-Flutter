import 'package:flutter/material.dart';
import 'lab1_mock_login/screens/login_screen.dart' as lab1;
import 'lab2_real_api_login/screens/login_screen.dart' as lab2;
import 'lab3_auto_login_logout/screens/splash_screen.dart' as lab3;
import 'lab4_firebase_google_signin/screens/auth_screen.dart' as lab4;
import 'lab5_notification/screens/notification_demo_screen.dart' as lab5;
import 'lab_full/screens/splash_screen.dart' as lab_full;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 10 - Authentication & Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LabMenuScreen(),
    );
  }
}

class LabMenuScreen extends StatelessWidget {
  const LabMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 10 - Menu'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.science,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Authentication & Notifications',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Select a lab to explore',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildLabCard(
            context,
            title: 'Lab 10.1',
            subtitle: 'Mock Login',
            description: 'Form validation & simulated backend authentication',
            icon: Icons.lock_outline,
            color: Colors.blue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab1.LoginScreen()),
            ),
          ),
          _buildLabCard(
            context,
            title: 'Lab 10.2',
            subtitle: 'Real API Login',
            description: 'Authentication using DummyJSON REST API',
            icon: Icons.api,
            color: Colors.deepPurple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab2.LoginScreen()),
            ),
          ),
          _buildLabCard(
            context,
            title: 'Lab 10.3',
            subtitle: 'Auto Login & Logout',
            description: 'Session management with SharedPreferences',
            icon: Icons.lock_clock,
            color: Colors.teal,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab3.SplashScreen()),
            ),
          ),
          _buildLabCard(
            context,
            title: 'Lab 10.4',
            subtitle: 'Firebase Google Sign-In',
            description: 'OAuth authentication with Firebase',
            icon: Icons.g_mobiledata,
            color: Colors.orange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab4.AuthScreen()),
            ),
          ),
          _buildLabCard(
            context,
            title: 'Lab 10.5',
            subtitle: 'Local Notifications',
            description: 'Push notifications integration',
            icon: Icons.notifications_active,
            color: Colors.red,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab5.NotificationDemoScreen()),
            ),
          ),
          _buildLabCard(
            context,
            title: 'Lab 10 Full',
            subtitle: 'Integrated Project',
            description: 'All features combined in one app',
            icon: Icons.dashboard,
            color: Colors.green,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const lab_full.SplashScreen()),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLabCard(
    BuildContext context, {
    required String title,
    required String subtitle,
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 18,
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
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
