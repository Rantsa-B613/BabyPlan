import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kellan/components/details_screen.dart';

class CustomAppNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 64.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Details_Screen(),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/list.svg",
                  height: 34.0,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Details_Screen(),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/add.svg",
                  height: 34.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Text(
                  "ça va ?",
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3.0,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      Text(
                        "Prennnons soins de votre ",
                        style: GoogleFonts.publicSans(
                          fontSize: 26.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "ENFANT",
                        style: GoogleFonts.righteous(
                          fontSize: 28.0,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        " ensemble !!! ",
                        style: GoogleFonts.publicSans(
                          fontSize: 28.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
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
