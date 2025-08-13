import mir.ndslice;
import std.stdio;

import datamanip;

void main()
{
   writeln("Test scaler");
   auto scaler = new StandardScaler!float();
   auto data = [1.0f, -1.0f, 2.0f, 2.0f, 0.0f, 0.0f, 0.0f, 1.0f, -1.0f].sliced(3, 3);

   scaler.fit(data);
   auto meanvalue = scaler.mean();
   writeln("Mean = ", meanvalue);
   // [1., 0., 0.33]
   auto scalevalue = scaler.scale();
   // [0.81, 0.81, 1.24]
   writeln("Scale = ", scalevalue);
   auto transformed = scaler.transform(data);
   // [0, -1.22474, 1.33631], [1.22474, 0, -0.267261], [-1.22474, 1.22474, -1.06904]
   writeln(transformed);

}

