import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'main.dart'; // We need this to navigate back to LoginPage on logout

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1ED), // light warm bg
      body: SafeArea(
        child: SingleChildScrollView(
          // Add some bottom padding to prevent the nav bar from covering content
          padding: const EdgeInsets.only(bottom: 88),
          child: Column(
            children: const [
              _HeaderCard(),
              SizedBox(height: 12),
              _ThoughtCard(),
              SizedBox(height: 12),
              _TopGridRow(),
              SizedBox(height: 12),
              _ExplorationsCard(),
              SizedBox(height: 12),
              _BottomGridRow(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF5C3D2B),
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_rounded),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Divya',
          ),
        ],
      ),
    );
  }
}

/* ============================== HEADER ============================== */

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7B4B84), Color(0xFF9D6EA6)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Arcs behind the avatar (progress arc)
          Positioned.fill(child: CustomPaint(painter: _ArcPainter())),

          // Top Row: greeting + small avatar emoji
          Positioned(
            top: 18,
            left: 18,
            child: Row(
              children: const [
                Text(
                  'Hey Divya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                Text('👧', style: TextStyle(fontSize: 22)),
              ],
            ),
          ),

          // Logout button on right
          Positioned(
            top: 12,
            right: 70, // Positioned to the left of the bell
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white, size: 24),
              onPressed: () async {
                // Check if the widget is still in the tree before navigating
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
          ),

          // Bell on right
          Positioned(
            top: 12,
            right: 16,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),

          // Title centered ABOVE the arc (Adjusted position)
          const Align(
            alignment: Alignment(0, -0.75), // MOVED UP
            child: Text(
              'Learning Level 3',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Avatar centered
          Align(
            alignment: const Alignment(0, 0.58),
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Image.asset('assets/char_img.png', height: 130),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Place the arc just above the avatar (Adjusted position)
    final center = Offset(size.width / 2, size.height * 0.72); // MOVED DOWN
    final radius = size.width * 0.38;

    final mainArc = Paint()
      ..color = Colors.white.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final outerArc = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final start = _deg(205);
    final sweep = _deg(135);

    final rect1 = Rect.fromCircle(center: center, radius: radius);
    final rect2 = Rect.fromCircle(center: center, radius: radius + 12);

    canvas.drawArc(rect1, start, sweep, false, mainArc);
    canvas.drawArc(rect2, start, sweep, false, outerArc);

    final knob = Offset(
      center.dx + radius * math.cos(start),
      center.dy + radius * math.sin(start),
    );
    final knobPaint = Paint()..color = Colors.white;
    canvas.drawCircle(knob, 6, knobPaint);
  }

  double _deg(double d) => d * math.pi / 180;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// All the other widget classes (_ThoughtCard, _TopGridRow, etc.) are below
// and do not need any changes.

/* ============================ THOUGHT CARD ============================ */
// ... (The rest of your code is unchanged) ...
class _ThoughtCard extends StatelessWidget {
  const _ThoughtCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1E4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Thought for the day',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'When we teach with curiosity, joy, and\ncare, children carry learning for life.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.35,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF76C447),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.psychology, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final active = i == 0;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 14 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active ? Colors.black54 : Colors.black26,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/* =============================== GRID =============================== */
class _TopGridRow extends StatelessWidget {
  const _TopGridRow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: _MiniCard(
              title: 'Maths',
              background: Color(0xFFE9EEF4),
              borderColor: Color(0xFFE0E5EA),
              trailingArrow: true,
              icon: Icons.category_rounded,
              iconColor: Color(0xFF6B1F1F),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniCard(
              title: 'Science',
              background: Color(0xFFEEF2F7),
              borderColor: Color(0xFFE2E6EC),
              trailingArrow: true,
              icon: Icons.biotech_rounded,
              iconColor: Color(0xFF2D4F7F),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomGridRow extends StatelessWidget {
  const _BottomGridRow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: _MiniCard(
              title: 'Tools',
              background: Color(0xFFF2F4E3),
              borderColor: Color(0xFFE2E6CF),
              trailingArrow: true,
              icon: Icons.handyman_rounded,
              iconColor: Colors.black,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniCard(
              title: 'Reflect',
              background: Color(0xFFF4E3D5),
              borderColor: Color(0xFFE8D4C3),
              trailingArrow: true,
              icon: Icons.psychology_alt_rounded,
              iconColor: Color(0xFFE09433),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String title;
  final Color background;
  final Color borderColor;
  final bool trailingArrow;
  final IconData? icon;
  final Color? iconColor;
  final String? imagePath;
  const _MiniCard({
    required this.title,
    required this.background,
    required this.borderColor,
    this.trailingArrow = false,
    this.icon,
    this.iconColor,
    // ignore: unused_element_parameter
    this.imagePath,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: imagePath != null
                ? Image.asset(imagePath!, height: 60, fit: BoxFit.contain)
                : Icon(icon, size: 58, color: iconColor ?? Colors.black87),
          ),
          if (trailingArrow)
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black45,
              ),
            ),
        ],
      ),
    );
  }
}

/* =========================== EXPLORATIONS =========================== */
class _ExplorationsCard extends StatelessWidget {
  const _ExplorationsCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE3DFEE), Color(0xFFF0D7DA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(
            Icons.travel_explore_rounded,
            size: 36,
            color: Color(0xFF3CB9B2),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Explorations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
