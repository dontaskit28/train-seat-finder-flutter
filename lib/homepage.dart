import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'components/cabin_widget.dart';
import 'provider/selection_button_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchText;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the SelectionButtonProvider to manage selected seats.
    SelectionButtonProvider seatsProvider =
        Provider.of<SelectionButtonProvider>(context, listen: true);

    // ItemScrollController to control scrolling to a specific seat.
    ItemScrollController scrollController = ItemScrollController();

    // Function to handle searching for a seat based on the entered text.
    void searchSeat() {
      var searchValue = num.tryParse(searchController.text);
      if (searchValue != null) {
        if (searchValue > 112 || searchValue < 1) {
          // Handle invalid input.
          debugPrint("Invalid Input");
          searchController.clear();
          setState(() {
            searchText = null;
          });
          return;
        }
        setState(() {
          searchText = searchController.text;
        });
        scrollController.scrollTo(
          // Scroll to the appropriate cabin based on the seat index.
          index: (num.parse(searchController.text) / 8).ceil() - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        debugPrint("Invalid Input");
      }
      setState(() {
        searchController.text = "";
      });
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      FocusScope.of(context).unfocus();
    }

    return Scaffold(
      // Bottom navigation bar for the "Confirm Selection" button.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            _showConfirmedSheets(
              context: context,
              seatsProvider: seatsProvider,
            );
          },
          backgroundColor: const Color(0xff126DCA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: const Text("Confirm Selection"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 10),
            const Row(
              children: [
                Text(
                  "Seat Finder",
                  style: TextStyle(
                    color: Color(0xff126DCA),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              // Search bar to enter the seat index.
              controller: searchController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                searchSeat();
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff126DCA)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff126DCA)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff126DCA)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff126DCA),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 32),
                      ),
                    ),
                    onPressed: searchSeat,
                    child: const Text("Find"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              // ScrollablePositionedList to display the cabin layouts.
              child: ScrollablePositionedList.builder(
                itemScrollController: scrollController,
                itemCount: 14,
                itemBuilder: (context, index) {
                  return Builder(
                    builder: (context) => CabinWidget(
                      index: index,
                      searchBarText: searchText,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the confirmed seat selection in a modal bottom sheet.
void _showConfirmedSheets({
  required BuildContext context,
  required SelectionButtonProvider seatsProvider,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(25),
        child: seatsProvider.selectedSeats.isEmpty
            ? const Center(child: Text("No Tickets Selected"))
            : Center(
                child: Column(
                  children: [
                    Text(
                      "Total Seats: ${seatsProvider.selectedSeats.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      // ListView to display the selected seats.
                      child: ListView.builder(
                        itemCount: seatsProvider.selectedSeats.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.grey.shade100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Seat No: ${seatsProvider.selectedSeats[index].seatIndex}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${seatsProvider.selectedSeats[index].seatType}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      );
    },
  );
}
