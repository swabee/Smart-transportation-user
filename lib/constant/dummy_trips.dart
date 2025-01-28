// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
// List<TripModel> dummytrips = [
//   TripModel(
//     id: 'trip_1',
//     destination: 'Thiruvananthapuram',
//     pickup: 'Moovattupuzha',
//     date: DateTime.now().add(const Duration(days: 1)),
//     departureTime: '06:00 AM',
//     duration: '6 hours 30 minutes',
//     arrivalTime: '12:30 PM',
//     busType: 'Luxury Bus',
//     depot: 'Moovattupuzha',
//     busNumber: 'Bus 201',
//     seatsAvailable: '50',
//     price: 'USD 70',
//     isSoldOut: false,
//     seats: List<int>.generate(50, (index) => index + 1),
//     bookedSeats: [1, 2, 3, 4, 5],
//     tripId: 'trip_1',
//     busId: 'bus_1',
//     stops: ['Moovattupuzha', 'Adoor', 'Thiruvananthapuram'],
//   ),
//   TripModel(
//     id: 'trip_2',
//     destination: 'Thiruvananthapuram',
//     pickup: 'Moovattupuzha',
//     date: DateTime.now().add(const Duration(days: 2)),
//     departureTime: '07:00 AM',
//     duration: '6 hours 45 minutes',
//     arrivalTime: '01:45 PM',
//     busType: 'Standard Bus',
//     depot: 'Moovattupuzha',
//     busNumber: 'Bus 202',
//     seatsAvailable: '50',
//     price: 'USD 60',
//     isSoldOut: false,
//     seats: List<int>.generate(50, (index) => index + 1),
//     bookedSeats: [6, 7, 8, 9],
//     tripId: 'trip_2',
//     busId: 'bus_2',
//     stops: ['Moovattupuzha', 'Adoor', 'Thiruvananthapuram'],
//   ),
//   TripModel(
//     id: 'trip_3',
//     destination: 'Kochi',
//     pickup: 'Alappuzha',
//     date: DateTime.now().add(const Duration(days: 3)),
//     departureTime: '08:00 AM',
//     duration: '5 hours',
//     arrivalTime: '01:00 PM',
//     busType: 'Luxury Bus',
//     depot: 'Alappuzha',
//     busNumber: 'Bus 301',
//     seatsAvailable: '50',
//     price: 'USD 65',
//     isSoldOut: false,
//     seats: List<int>.generate(50, (index) => index + 1),
//     bookedSeats: [10, 11, 12],
//     tripId: 'trip_3',
//     busId: 'bus_3',
//     stops: ['Alappuzha', 'Changanassery', 'Kochi'],
//   ),
//   TripModel(
//     id: 'trip_4',
//     destination: 'Kannur',
//     pickup: 'Kollam',
//     date: DateTime.now().add(const Duration(days: 4)),
//     departureTime: '09:00 AM',
//     duration: '7 hours',
//     arrivalTime: '04:00 PM',
//     busType: 'Express Bus',
//     depot: 'Kollam',
//     busNumber: 'Bus 401',
//     seatsAvailable: '50',
//     price: 'USD 75',
//     isSoldOut: false,
//     seats: List<int>.generate(50, (index) => index + 1),
//     bookedSeats: [13, 14, 15],
//     tripId: 'trip_4',
//     busId: 'bus_4',
//     stops: ['Kollam', 'Pathanamthitta', 'Kannur'],
//   ),
//   TripModel(
//     id: 'trip_5',
//     destination: 'Palakkad',
//     pickup: 'Kochi',
//     date: DateTime.now().add(const Duration(days: 5)),
//     departureTime: '10:00 AM',
//     duration: '5 hours 30 minutes',
//     arrivalTime: '03:30 PM',
//     busType: 'Luxury Bus',
//     depot: 'Kochi',
//     busNumber: 'Bus 502',
//     seatsAvailable: '50',
//     price: 'USD 70',
//     isSoldOut: false,
//     seats: List<int>.generate(50, (index) => index + 1),
//     bookedSeats: [16, 17, 18],
//     tripId: 'trip_5',
//     busId: 'bus_5',
//     stops: ['Kochi', 'Aluva', 'Palakkad'],
//   ),
// ];



// Future<void> addTripsToFirestore(List<TripModel> trips) async {
//   // Reference to the Firestore trips collection
//   final CollectionReference tripsCollection =
//       FirebaseFirestore.instance.collection('trips');
  
//   // Loop through each trip and add it to Firestore
//   for (var trip in trips) {
//     try {
//       // Adding the trip data to the 'trips' collection
//       await tripsCollection.doc(trip.id).set({
//         'id': trip.id,
//         'destination': trip.destination,
//         'pickup': trip.pickup,
//         'date': trip.date,
//         'departureTime': trip.departureTime,
//         'duration': trip.duration,
//         'arrivalTime': trip.arrivalTime,
//         'busType': trip.busType,
//         'depot': trip.depot,
//         'busNumber': trip.busNumber,
//         'seatsAvailable': trip.seatsAvailable,
//         'price': trip.price,
//         'isSoldOut': trip.isSoldOut,
//         'seats': trip.seats,
//         'bookedSeats': trip.bookedSeats,
//         'tripId': trip.tripId,
//         'busId': trip.busId,
//         'stops': trip.stops,
//       });
//       print("Trip ${trip.id} added successfully.");
//     } catch (e) {
//       print("Error adding trip ${trip.id}: $e");
//     }
//   }
// }
