import 'package:hotel_pbp/invoice/model/hotel_room.dart';

String getSubTotal(List<HotelRoom> hotelRooms) {
  return hotelRooms
      .fold(0.0,
          (double prev, element) => prev + (element.amount * element.price))
      .toStringAsFixed(2);
}

String getPPNTotal(List<HotelRoom> hotelRooms) {
  return hotelRooms
      .fold(
        0.0,
        (double prev, next) =>
            prev + ((next.price / 100 * next.ppnInPercent) * next.amount),
      )
      .toStringAsFixed(2);
}
