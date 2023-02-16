class SizeConv {
  static getSize(value) {
    switch (value) {
      case '00':
        return 'XS';
      case '01':
        return 'S';
      case '02':
        return 'M';
      case '03':
        return 'L';
      case '04':
        return 'XL';
      case '05':
        return 'XXL';
      case '06':
        return 'XXXL';
      case '99':
        return 'FREE SIZE';
      default:
        return value;
    }
  }

  static getCode(value) {
    switch (value) {
      case 'XS':
        return '00';
      case 'S':
        return '01';
      case 'M':
        return '02';
      case 'L':
        return '03';
      case 'XL':
        return '04';
      case 'XXL':
        return '05';
      case 'XXXL':
        return '06';
      case 'FREE SIZE':
        return '99';
      default:
        return value;
    }
  }
}
