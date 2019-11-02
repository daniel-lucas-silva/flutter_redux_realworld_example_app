part of utils;

double norm(value, min, max) => (value - min) / (max - min);

double lerp( double norm, num min, num max) => (max - min) * norm + min;

double map(double value, double sourceMin, double sourceMax, double destMin, double destMax) {
  return lerp(norm(value, sourceMin, sourceMax), destMin, destMax);
}
