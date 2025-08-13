# datamanip
Data preprocessing, manipulation and augmentation.

Currently implement only standardization, or mean removal and variance scaling.

## Example usage

```d
import mir.ndslice;
import std.stdio;

import datamanip;

void main()
{
   auto scaler = new StandardScaler!float();
   auto data = [1.0f, -1.0f, 2.0f, 2.0f, 0.0f, 0.0f, 0.0f, 1.0f, -1.0f].sliced(3, 3);

   scaler.fit(data);
   auto meanvalue = scaler.mean();
   writeln("Mean = ", meanvalue);
   auto scalevalue = scaler.scale();
   writeln("Scale = ", scalevalue);
   auto transformed = scaler.transform(data);
   writeln(transformed);
}
```

