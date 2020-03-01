# SwiftOverCoffee3Challenge

## Considerations

I used Xcode 11.4 beta to get the best error messages - based on suggestion on Swift over Coffee. :-)

Adding all the sliders was inspired by the excellent dotSwift talk by Tobias Due Munk.

## Challenges faced

Standard color blending didn't work exactly as I envisioned. Luckily the `.hardLight` blend mode appears to work quite nicely.

I quickly ended up with expressions that could not be type checked in a reasonable time when doing angle math with a ternary operator. 
I tried to refactor the calculations to happen in the beginning of each `ForEach` loop, but I could not make that work. 
I ended up moving the calculations to a function instead.

I found it a bit annoying that the compiler could not infer the type in the specified ranges when using a `Slider`. It would look nicer if you didn't have to add explicit types to the ranges.

## Time constraints 

I didn't have time to add a `Slider` for the petal count. I did not really know the best place to 'map' the floating point values from a slider to integral ones.

It would have been nice to use proportionate sizes for the petals, but I know too little about relative sizing and was not prepared to wrestle with GeometryReader.

Also I would have liked to add a color picker. :-)

I knew up front that I would not have time to add the quickly fading phantom image that appears when the flower is closing in the original animation.

## Epilogue

After the challenge, I have spent yet another hour of playing around - and it's so much fun!
Please checkout out the branch 'playingaround' for more experiments.

I have learned to make animations local to specific actions and even to specific bindings! How cool is that?

I have made petal counts, color, opacity and blend modes adjustable among other things.

Looking forward to playing with it even more! :-)
