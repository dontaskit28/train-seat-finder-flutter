import 'package:flutter/material.dart';
import '../model/seat.dart';

class SelectionButtonProvider with ChangeNotifier {
  // List to hold the selected seats.
  final List<Seat> _selectedSeats = [];

  // Getter to access the selected seats list from outside the class.
  List<Seat> get selectedSeats => _selectedSeats;

  // Method to add a seat to the list of selected seats.
  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    // Notify all the listeners (usually widgets) that depend on this provider.
    notifyListeners();
  }

  // Method to remove a seat from the list of selected seats.
  void removeSeat(Seat seat) {
    _selectedSeats.remove(seat);
    // Notify all the listeners (usually widgets) that depend on this provider.
    notifyListeners();
  }

  // Method to check if a seat is selected.
  bool isSeatSelected(Seat seat) {
    return _selectedSeats.contains(seat);
  }
}
