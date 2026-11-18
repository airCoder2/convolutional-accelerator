


// so basically for using the accelerator, I have to do 4 channels at once
// load 4 filters, and make compuation on 4 filters simultaneously.
// write the biases scales and everything there
// poll the conv_idle line, and once it is done, move on to the next batch of 4
// again put new scales, and so on.


// ACTUALLY FIRST DO JUST 4 channels and confirm you have the right ouputs for those channels
// once it is good add the next four and so on

// first do it outise of any control statements
// in an unrolled loop fashion
// once it works, then you can write a nice fucntion that does all of that


// to start off, compute 4 channels in software and then write a funciton
// that can compare those 4 against the expected feature map

// OKAY ALL 4 channels passed,
// Full layers passed as well individually
// I haven't connected them yet.

// NEXT DO DENSE LAYER AND CONVOLUTION