module datamanip.preprocess;

import datamanip.utils;

import mir.ndslice;
import numir;

abstract class DataPreprocess(T) {}

class StandardScaler(T): DataPreprocess!T {
private:
   Slice!(T*) meanValue;
   Slice!(T*) scaleValue;

public:
   this() {}

   ~this() {}

   Slice!(const(T)*) mean() const { return meanValue;}

   Slice!(const(T)*) scale() const {return scaleValue;}

   void fit(Slice!(const(T)*, 2) x) {
      size_t n = x.shape[0];
      size_t k = x.shape[1];
      meanValue = datamanip.utils.mean!T(x, 0);
      scaleValue = datamanip.utils.std!T(x, 0);
   }

   Slice!(T*, 2) transform(Slice!(const(T)*, 2) x) {
      size_t n = x.shape[0];
      size_t k = x.shape[1];

      auto xscaled = empty!T(n, k);
      foreach(i; 0..n) {
         foreach(j; 0..k) {
            xscaled[i,j] = (x[i,j] - meanValue[j]) / scaleValue[j];
         }
      }
      return xscaled;
   }
}

