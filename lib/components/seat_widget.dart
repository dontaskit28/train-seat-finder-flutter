import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/seat.dart';
import '../provider/selection_button_provider.dart';

class SeatWidget extends StatefulWidget {
  SeatWidget({
    Key? key,
    required this.seatIndex,
    required this.seatType,
    this.searchBarText,
  }) : super(key: ValueKey(seatIndex));

  // The seat index and type passed to the widget.
  final int seatIndex;
  final String seatType;

  // Optional search bar text that may be passed to the SeatWidget.
  final String? searchBarText;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget>
    with AutomaticKeepAliveClientMixin<SeatWidget> {
  @override
  bool get wantKeepAlive => true;

  // A Seat object to represent the current seat in the widget's state.
  Seat seat = Seat();

  @override
  void initState() {
    super.initState();
    // Initializing the seat with the seatIndex and seatType provided to the widget.
    seat = Seat(seatIndex: widget.seatIndex, seatType: widget.seatType);
  }

  @override
  Widget build(BuildContext context) {
    // Call super.build to ensure the AutomaticKeepAliveClientMixin works correctly.
    super.build(context);

    // Use the Consumer widget to listen to the SelectionButtonProvider.
    return Consumer<SelectionButtonProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          // Add an onTap handler to toggle the selection of the seat when tapped.
          onTap: () {
            if (provider.selectedSeats.contains(seat)) {
              // If the seat is already selected, remove it from the list of selected seats.
              provider.removeSeat(seat);
            } else {
              // If the seat is not selected, add it to the list of selected seats.
              provider.addSeat(seat);
            }
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  // Add a shadow effect when the seat matches the search bar text.
                  color: (widget.searchBarText == widget.seatIndex.toString())
                      ? Colors.blue.withOpacity(0.5)
                      : Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              border: Border.all(
                // Add a border when the seat matches the search bar text.
                color: (widget.searchBarText == widget.seatIndex.toString())
                    ? const Color(0xff126DCA)
                    : Colors.transparent,
                width: 2,
              ),
              color: (provider.selectedSeats.contains(seat))
                  ? const Color(0xff126DCA) // Seat is selected.
                  : const Color(0xffCEEAFF), // Seat is not selected.
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.seatIndex.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: (provider.selectedSeats.contains(seat))
                        ? const Color(
                            0xffCEEAFF) // Text color when seat is selected.
                        : const Color(
                            0xff126DCA), // Text color when seat is not selected.
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.seatType,
                  style: TextStyle(
                    fontSize: 12,
                    color: (provider.selectedSeats.contains(seat))
                        ? const Color(
                            0xffCEEAFF,
                          ) // Text color when seat is selected.
                        : const Color(
                            0xff126DCA,
                          ), // Text color when seat is not selected.
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
