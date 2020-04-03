# CORDIC_SIMULATOR

This repo contains two Jupyter Notebooks which aim to simulate and find accuracy in the CORDIC implementation as well as the Custom Instruction which implements the equation:

0.5x + x^2 * cos((x - 128) /128) 


The final implementation simulates both CORDIC and the CUSTOM_INSTRUCTION as a function and is therefore recommended to understand the high level implementation. In addition to this, 4 tests are readily available in the FixedPointErrorAnalysis.ipynb which we used to produce the Matlab plots seen in the Final Report. 

The width of the bit length can be changed with _width variable. The _adj variable changes x in the Qx.y Fixed-Point Format (x for integer, y for fractional bits). 

Lastly, the FixedPointErrorAnalysis.ipynb analyses the error between the Fixed Point Custom Instruction implementation and the IEEE 32-bit Floating-Point implementation. They are both compared to the higher accuracy IEEE 64-bit Floating Point, which is used in Matlab. 

The processed data is then stored in .mat files which plot the data with Matlab software. 
