class Hotel {
  final int? id;
  String? assets, name, desc, rating, price, jumlah;

  Hotel({
    this.id,
    this.assets,
    this.name,
    this.desc,
    this.rating,
    this.price,
    this.jumlah
  });
}

// List<Hotel> hotelList = [
//   Hotel(
//     assets: 'assets/hotel1.jpg',
//     name: 'Hotel 1',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.5',
//     price: 'Rp. 200.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel2.jpg',
//     name: 'Hotel 2',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.7',
//     price: 'Rp. 250.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel3.jpg',
//     name: 'Hotel 3',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.0',
//     price: 'Rp. 280.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel4.jpg',
//     name: 'Hotel 4',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.1',
//     price: 'Rp. 240.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel5.jpg',
//     name: 'Hotel 5',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '3.9',
//     price: 'Rp. 220.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel16.jpg',
//     name: 'Hotel 6',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.8',
//     price: 'Rp. 295.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel7.jpg',
//     name: 'Hotel 7',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.3',
//     price: 'Rp. 230.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel8.jpg',
//     name: 'Hotel 8',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.6',
//     price: 'Rp. 195.000'
//   ),
//   Hotel(
//     assets: 'assets/hotel9.jpg',
//     name: 'Hotel 9',
//     desc: 'Ut finibus interdum sapien, a maximus purus pretium non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod tortor lectus, ut sagittis lectus interdum aliquet. In laoreet, libero sed rutrum laoreet, quam justo cursus odio, id dapibus purus urna nec ex. Pellentesque ac efficitur urna. Donec purus tellus, iaculis sit amet dapibus eu, vehicula id metus. Sed convallis malesuada ligula non aliquet. Morbi sit amet velit quis dui lobortis facilisis. Donec ut pellentesque ante. Maecenas auctor ac leo et varius.',
//     rating: '4.8',
//     price: 'Rp. 200.000'
//   ),

// ];