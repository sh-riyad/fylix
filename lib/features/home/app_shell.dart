import 'package:flutter/material.dart';

import '../media/media_page.dart';
import '../files/files_page.dart';
import '../notes/notes_page.dart';
import '../recent/recent_page.dart';
import '../account/your_data_page.dart';
import '../account/settings_page.dart';
import '../account/help_feedback_page.dart';
import '../account/privacy_policy_page.dart';
import '../account/terms_of_service_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const <Widget>[
    MediaPage(),
    FilesPage(),
    NotesPage(),
    RecentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fylix'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _showAccountSheet,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) => setState(() => _currentIndex = index),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.photo_outlined),
            selectedIcon: Icon(Icons.photo),
            label: 'Media',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Files',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_outlined),
            selectedIcon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Recent',
          ),
        ],
      ),
    );
  }

  Future<void> _showAccountSheet() async {
    final BuildContext rootContext = context;
    final String? value = await showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        bool actionHandled = false;
        void handle(String v) {
          if (actionHandled) return;
          actionHandled = true;
          Navigator.of(context).pop(v);
        }
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {}, // Prevents tap from bubbling up
              child: DraggableScrollableSheet(
                initialChildSize: 0.78,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // Project Name Section
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                          Text(
                                            'FyLix',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Profile Section (2nd div with always visible content)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Profile header without arrow
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              children: <Widget>[
                                                const CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(Icons.person, color: Colors.white),
                                                ),
                                                const SizedBox(width: 12),
                                                const Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('Your Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                                      SizedBox(height: 2),
                                                      Text('user@example.com', style: TextStyle(color: Colors.black54)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                          // Always visible account actions
                                          const Divider(height: 1, indent: 16, endIndent: 16),
                                          ListTile(
                                            leading: const Icon(Icons.person_add_alt_1_outlined),
                                            title: const Text('Add another account'),
                                            onTap: () => handle('add_account'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.cleaning_services_outlined),
                                            title: const Text('Free up space from this device'),
                                            onTap: () => handle('free_up_space'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.logout),
                                            title: const Text('Logout'),
                                            onTap: () => handle('logout'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Menu Items Section (3rd div)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey.shade200),
                                      ),
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(Icons.settings_outlined),
                                            title: const Text('Settings'),
                                            onTap: () => handle('settings'),
                                          ),
                                          const Divider(height: 1, indent: 16, endIndent: 16),
                                          ListTile(
                                            leading: const Icon(Icons.verified_user_outlined),
                                            title: const Text('Your data in Fylix'),
                                            onTap: () => handle('your_data'),
                                          ),
                                          const Divider(height: 1, indent: 16, endIndent: 16),
                                          ListTile(
                                            leading: const Icon(Icons.help_outline),
                                            title: const Text('Help and feedback'),
                                            onTap: () => handle('help_feedback'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Footer links
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () => handle('privacy'),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 12),
                                              child: Text('Privacy Policy', style: TextStyle(color: Colors.black54)),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => handle('terms'),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 12),
                                              child: Text('Terms of Service', style: TextStyle(color: Colors.black54)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    if (!mounted) return;
    if (value == null) return;
    
    // Navigate to pages and then show sheet again when returning
    Widget? targetPage;
    switch (value) {
      case 'your_data':
        targetPage = const YourDataPage();
        break;
      case 'settings':
        targetPage = const SettingsPage();
        break;
      case 'help_feedback':
        targetPage = const HelpFeedbackPage();
        break;
      case 'privacy':
        targetPage = const PrivacyPolicyPage();
        break;
      case 'terms':
        targetPage = const TermsOfServicePage();
        break;
      default:
        return;
    }
    
    if (targetPage != null) {
      await Navigator.of(rootContext).push(MaterialPageRoute(builder: (_) => targetPage!));
      // Show the account sheet again after returning from the page
      if (mounted) {
        _showAccountSheet();
      }
    }
  }
}