module datamanip.utils;

import mir.ndslice;
import numir;

import std.math: sqrt;

/++
Sum of an array
+/
T sum(T, SliceKind Kind)(Slice!(const(T)*, 1, Kind) x) {
   T s = 0;
   foreach(i; 0..x.elementCount) {
      s += x[i];
   }
   return s;
}

/++
Mean of an array
+/
T mean(T, SliceKind Kind)(Slice!(const(T)*, 1, Kind) x) {
   T s = sum(x);
   return s / cast(T) x.elementCount;
}

/++
Mean along an axis
+/
Slice!(T*) mean(T)(Slice!(const(T)*, 2) x, size_t axis) {
   assert(axis == 0 || axis == 1, "Parameter axis should be equal to 0 or 1");

   size_t n = x.shape[0];
   size_t k = x.shape[1];
   if (axis == 0) {
      auto m = empty!T(k);
      foreach(i; 0..k) {
         m[i] = mean(x[0..n, i]);
      }
      return m;
   } else {
      auto m = empty!T(n);
      foreach(i; 0..n) {
         m[i] = mean(x[i, 0..k]);
      }
      return m;
   }
}

/++
Standard deviation of an array
+/
T std(T, SliceKind Kind)(Slice!(const(T)*, 1, Kind) x) {
   size_t n = x.elementCount;
   auto diff = empty!T(n);
   T m = mean(x);
   foreach(i; 0..n) {
      diff[i] = x[i] - mean(x);
      diff[i] = diff[i] * diff[i];
   }
   T s = sum(diff);

   return sqrt(s / cast(T) x.elementCount);
}

/++
Standard deviation along an axis
+/
Slice!(T*) std(T)(Slice!(const(T)*, 2) x, size_t axis) {
   assert(axis == 0 || axis == 1, "Parameter axis should be equal to 0 or 1");

   size_t n = x.shape[0];
   size_t k = x.shape[1];
   if (axis == 0) {
      auto m = empty!T(k);
      foreach(i; 0..k) {
         m[i] = std(x[0..n, i]);
      }
      return m;
   } else {
      auto m = empty!T(n);
      foreach(i; 0..n) {
         m[i] = std(x[i, 0..k]);
      }
      return m;
   }
}

