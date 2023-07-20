import 'package:flutter/material.dart';
import 'custom_clip_path.dart';
import 'seat_widget.dart';

class CabinWidget extends StatelessWidget {
  const CabinWidget({
    super.key,
    required this.index,
    this.searchBarText,
  });

  // Index of the cabin, used to calculate the seat indexes.
  final int index;

  // Optional search bar text that may be passed to SeatWidget.
  final String? searchBarText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            // Upper row of seats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left stack for upper seats
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Custom ClipPath to create a curved top container.
                    ClipPath(
                      clipper: MyCustomCliperFromTop(),
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    // Row of individual SeatWidgets with seatType "Upper", "Middle", "Lower".
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          // Seat with seatIndex = 1 + index * 8 and seatType = "Upper".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 1 + index * 8,
                            seatType: "Upper",
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          // Seat with seatIndex = 2 + index * 8 and seatType = "Middle".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 2 + index * 8,
                            seatType: "Middle",
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          // Seat with seatIndex = 3 + index * 8 and seatType = "Lower".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 3 + index * 8,
                            seatType: "Lower",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Right stack for "Side Up" seat
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Custom ClipPath to create a curved top container.
                    ClipPath(
                      clipper: MyCustomCliperFromTop(),
                      child: Container(
                        height: 60,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    // Seat with seatIndex = 7 + index * 8 and seatType = "Side Up".
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SeatWidget(
                        searchBarText: searchBarText,
                        seatIndex: 7 + index * 8,
                        seatType: "Side Up",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // Lower row of seats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left stack for lower seats
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Custom ClipPath to create a curved bottom container.
                    ClipPath(
                      clipper: MyCustomCliperFromBottom(),
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    // Row of individual SeatWidgets with seatType "Upper", "Middle", "Lower".
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          // Seat with seatIndex = 6 + index * 8 and seatType = "Upper".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 6 + index * 8,
                            seatType: "Upper",
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          // Seat with seatIndex = 5 + index * 8 and seatType = "Middle".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 5 + index * 8,
                            seatType: "Middle",
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          // Seat with seatIndex = 4 + index * 8 and seatType = "Lower".
                          SeatWidget(
                            searchBarText: searchBarText,
                            seatIndex: 4 + index * 8,
                            seatType: "Lower",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Right stack for "Side Low" seat
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Custom ClipPath to create a curved bottom container.
                    ClipPath(
                      clipper: MyCustomCliperFromBottom(),
                      child: Container(
                        height: 60,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    // Seat with seatIndex = 8 + index * 8 and seatType = "Side Low".
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SeatWidget(
                        searchBarText: searchBarText,
                        seatIndex: 8 + index * 8,
                        seatType: "Side Low",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
