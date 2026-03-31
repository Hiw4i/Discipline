import 'package:flutter/material.dart';
import 'package:disciplite/components/settings_components/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;

    return Scaffold(

      body: isDesktop
        ? Row(
            children: [
              Expanded(child: _buildList(isDesktop: true)),
              const VerticalDivider(width: 1),
              Expanded(flex: 2, child: _buildRightContent()),
            ]
          )
        : _buildList(isDesktop: false)

    );
  }


  Widget _buildList({required bool isDesktop}) {

    return ListView(
      children: [
        _buildGroupTitle(
          "Focus & Habits", [
            SettingsTile(
              icon: Icons.track_changes,
              title: "Daily Goals",
              isFirst: true,
              isSelected: _selectedIndex == 1,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            SettingsTile(
              icon: Icons.timer_outlined,
              title: "Focus Mode",
              isSelected: _selectedIndex == 2,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            SettingsTile(
              icon: Icons.auto_graph,
              title: "Progress Tracking",
              isLast: true,
              isSelected: _selectedIndex == 3,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 3),
            ),
          ]
        ),

        _buildGroupTitle(
          "Experience", [
            SettingsTile(
              icon: Icons.palette_outlined,
              title: "Appearance",
              isFirst: true,
              isSelected: _selectedIndex == 4,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 4),
            ),
            SettingsTile(
              icon: Icons.vibration,
              title: "Haptic Feedback",
              isDesktop: isDesktop,
              isSelected: _selectedIndex == 5,
              onTap: () => setState(() => _selectedIndex = 5),
            ),
            SettingsTile(
              icon: Icons.notifications_active_outlined,
              title: "Smart Reminders",
              isLast: true,
              isSelected: _selectedIndex == 6,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 6),
            ),
          ]
        ),

        _buildGroupTitle(
          "Account", [
            SettingsTile(
              icon: Icons.cloud_sync_outlined,
              title: "Cloud Backup",
              isFirst: true,
              isSelected: _selectedIndex == 7,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 7),
            ),
            SettingsTile(
              icon: Icons.info_outline,
              title: "About Disciplite",
              isLast: true,
              isSelected: _selectedIndex == 8,
              isDesktop: isDesktop,
              onTap: () => setState(() => _selectedIndex = 8),
            ),
          ]
        ),
      ],
    );
  }

  Widget _buildGroupTitle(String title, List<SettingsTile> tiles) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 48, top: 32, bottom: 12),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: tiles),
        ),
      ],
      
    );
  }

  Widget _buildRightContent() {
    Widget content;

    if (_selectedIndex == 0) {
      content = const Text("Select a setting from the left");
    } else {
      content = Text("Page number $_selectedIndex");
    }

    return Center(child: content);
  }

}
