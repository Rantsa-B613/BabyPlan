import 'package:flutter/material.dart';
import 'package:kellan/components/details_health.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:kellan/components/details_screen.dart';

class CustomAppNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 60.0),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bonjour ! ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "Pennons soins de vous ✨",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HealthScreen(),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 125,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.cover, // Ou utilisez un autre mode d'ajustement selon vos besoins
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Comment ça va ?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5,),
                            const Text(
                              "Votre carnet de médicale est présent.",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height:  12,),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HealthScreen(),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Vérifier",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
