import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

// State class
class SearchForBookingState extends Equatable {
  final int? selectedDestination;
  final int? selectedPickup;
  final Timestamp? selectedDate;
  final List<TripModel> availableTripsList;
  List<int>? selectedSeates; // Removed final here

  SearchForBookingState(
      {this.selectedDestination,
      this.selectedPickup,
      this.selectedDate,
      this.availableTripsList = const [],
      this.selectedSeates});

  SearchForBookingState copyWith({
   int? selectedDestination,
  int? selectedPickup,
 Timestamp? selectedDate,
    List<TripModel>? availableTripsList,
    final List<int>? selectedSeates,
  }) {
    return SearchForBookingState(
        selectedDestination: selectedDestination ?? this.selectedDestination,
        selectedPickup: selectedPickup ?? this.selectedPickup,
        selectedDate: selectedDate ?? this.selectedDate,
        availableTripsList: availableTripsList ?? this.availableTripsList,
        selectedSeates: selectedSeates ?? this.selectedSeates);
  }

  @override
  List<Object?> get props => [
        selectedDestination,
        selectedPickup,
        selectedDate,
        availableTripsList,
        selectedSeates
      ];
}

// Cubit class
class SearchForBookingCubit extends Cubit<SearchForBookingState> {
  SearchForBookingCubit() : super(SearchForBookingState());

  void updatePickup(int pickup) {
    emit(state.copyWith(selectedPickup: pickup));
  }

  void updateDestination(int destination) {
    emit(state.copyWith(selectedDestination: destination));
  }

  void updateSelectedSeats(int seatNumber) {
    // Ensure selectedSeates is initialized if it is null
    state.selectedSeates ??= [];

    // Check if the seat is already selected
    if (state.selectedSeates!.contains(seatNumber)) {
      // If it exists, remove it from the list
      state.selectedSeates!.remove(seatNumber);
    } else {
      // Otherwise, add the seat number to the list
      state.selectedSeates!.add(seatNumber);
    }

    // Emit the new state with updated selected seats
    emit(state.copyWith(selectedSeates: List.from(state.selectedSeates!)));
  }

  void updateBookingDate(Timestamp date) {
    emit(state.copyWith(selectedDate: date));
  }

  Stream<List<TripModel>> streamAvailableBookingTrips() async* {
    if (state.selectedPickup != null) {
      yield* FirebaseFirestore.instance
          .collection('trips')
          .snapshots()
          .map((snapshot) {
        List<TripModel> trips = snapshot.docs.map((doc) {
          return TripModel.fromJson(doc.data());
        }).toList();

        final pickUp = state.selectedPickup;
        final destination = state.selectedDestination;

        List<TripModel> availableTrips = trips.where((trip) {
          int pickUpIndex =
              trip.stopsModel.indexWhere((element) => element.depoId == pickUp);

          int destinationIndex = trip.stopsModel
              .indexWhere((element) => element.depoId == destination);
          print( 'pickUp id : $pickUp');
          return pickUpIndex != -1 &&
              destinationIndex != -1 &&
              destinationIndex > pickUpIndex;
        }).toList();

        // If no trips match, return all trips
        return availableTrips.isNotEmpty ? availableTrips : trips;
      });
    } else {
      // If pickup or destination is null, yield an empty list
      yield [];
    }
  }

  int findDifferenceBetweenNodes(TripModel tripModel) {
    final pickUp = state.selectedPickup;
    final destination = state.selectedDestination;

    if (pickUp == null) {
      // Return null if either pickup or destination is not selected
      return 0;
    }

    int pickUpIndex =
        tripModel.stopsModel.indexWhere((element) => element.depoId == pickUp);

    int destinationIndex = tripModel.stopsModel
        .indexWhere((element) => element.depoId == destination);

    if (pickUpIndex != -1 &&
        destinationIndex != -1 &&
        destinationIndex > pickUpIndex) {
      return destinationIndex - pickUpIndex;
    } else {
      // Return null if either pickup or destination is not found or if the destination comes before pickup
      return 0;
    }
  }
  // List<TripModel> searchTrips(
  //     String pickUp, String dropOff, List<TripModel> trips) {
  //   return trips.where((trip) {
  //     int pickUpIndex = trip.stops.indexOf(pickUp);
  //     int dropOffIndex = trip.stops.indexOf(dropOff);
  //     return pickUpIndex != -1 &&
  //         dropOffIndex != -1 &&
  //         pickUpIndex < dropOffIndex;
  //   }).toList();
  // }
}
