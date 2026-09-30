import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff5f7),

      // APP BAR

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        foregroundColor: Colors.black87,

        title: const Text(
          "About Us",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // =================================================
            // TOP PROFILE / LOGO CARD
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Colors.red,
                    Colors.pinkAccent,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.red.withOpacity(0.20),

                    blurRadius: 18,

                    offset:
                    const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // LOGO

                  Container(
                    height: 105,
                    width: 105,

                    decoration:
                    const BoxDecoration(
                      color: Colors.white,

                      shape:
                      BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.favorite,
                      size: 58,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Matrimonial",
                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Find Your Perfect Match ❤️",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // ABOUT APP
            // =================================================

            sectionTitle(
              Icons.info_outline,
              "About Our App",
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,

              padding:
              const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 12,

                    offset:
                    const Offset(0, 5),
                  ),
                ],
              ),

              child: const Text(
                "Matrimonial is a simple and user-friendly "
                    "application designed to manage user profiles "
                    "and help users find their perfect match. "
                    "You can create profiles, view user details, "
                    "manage favourite profiles and update user "
                    "information easily.",

                textAlign:
                TextAlign.center,

                style: TextStyle(
                  fontSize: 15,

                  height: 1.6,

                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // =================================================
            // FEATURES
            // =================================================

            sectionTitle(
              Icons.auto_awesome,
              "App Features",
            ),

            const SizedBox(height: 12),

            featureCard(
              icon: Icons.person_add_alt_1,
              title: "Create Profile",
              description:
              "Create and save matrimonial user profiles.",
              color: Colors.blue,
            ),

            featureCard(
              icon: Icons.people_alt_outlined,
              title: "User List",
              description:
              "View and manage all registered profiles.",
              color: Colors.deepPurple,
            ),

            featureCard(
              icon: Icons.favorite,
              title: "Favourite",
              description:
              "Save your favourite profiles for easy access.",
              color: Colors.red,
            ),

            featureCard(
              icon: Icons.search,
              title: "Easy Search",
              description:
              "Quickly search profiles by name, city or email.",
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            // =================================================
            // MISSION
            // =================================================

            Container(
              width: double.infinity,

              padding:
              const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.pink.shade50,

                borderRadius:
                BorderRadius.circular(22),

                border: Border.all(
                  color: Colors.pink.shade100,
                ),
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.handshake_outlined,
                    size: 45,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Our Goal",
                    style: TextStyle(
                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,

                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Helping people connect, discover "
                        "and build meaningful relationships.",

                    textAlign:
                    TextAlign.center,

                    style: TextStyle(
                      fontSize: 14,

                      height: 1.5,

                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // VERSION
            // =================================================

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.04),

                    blurRadius: 8,
                  ),
                ],
              ),

              child: const Row(
                mainAxisSize:
                MainAxisSize.min,

                children: [
                  Icon(
                    Icons.phone_android,
                    size: 18,
                    color: Colors.red,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Version 1.0.0",

                    style: TextStyle(
                      fontSize: 14,

                      fontWeight:
                      FontWeight.w600,

                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // =================================================
            // FOOTER
            // =================================================

            const Text(
              "Made with ❤️ for meaningful relationships",

              textAlign:
              TextAlign.center,

              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget sectionTitle(
      IconData icon,
      String title,
      ) {
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,

          decoration: BoxDecoration(
            color:
            Colors.red.withOpacity(0.10),

            borderRadius:
            BorderRadius.circular(11),
          ),

          child: Icon(
            icon,
            color: Colors.red,
            size: 21,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,

          style: const TextStyle(
            fontSize: 19,

            fontWeight:
            FontWeight.bold,

            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // FEATURE CARD
  // ==========================================================

  Widget featureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: double.infinity,

      margin:
      const EdgeInsets.only(bottom: 12),

      padding:
      const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),

            blurRadius: 10,

            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ICON

          Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              color:
              color.withOpacity(0.10),

              borderRadius:
              BorderRadius.circular(15),
            ),

            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

          // TEXT

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style:
                  const TextStyle(
                    fontSize: 16,

                    fontWeight:
                    FontWeight.bold,

                    color:
                    Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,

                  style:
                  const TextStyle(
                    fontSize: 12,

                    height: 1.4,

                    color:
                    Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}