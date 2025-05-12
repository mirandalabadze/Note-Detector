# Musical Note Detector

This MATLAB project is designed to detect a musical note from an input audio signal using a narrowband second-order IIR filter approach. The core idea is based on the structure of the chromatic scale within one octave, which contains 13 notes including the base note.

## How It Works
The fundamental frequency of this octave, denoted as f₀, is determined by analyzing a reference audio file called `Note02.wav`. Specifically, the function uses the power spectrum of this file and identifies the frequency with the highest amplitude, which is assumed to be f₀. Once this base frequency is known, the remaining 12 note frequencies are calculated using the formula:

```
fn = f₀ · 2^(n/12)
```

where `n` ranges from 1 to 12. These represent all the possible notes in the octave.

## Note Detection
To identify which note is present in a given input signal, the function constructs 13 narrowband second-order IIR bandpass filters, each tuned to one of the 13 note frequencies. These filters are designed using two complex conjugate poles placed at an angle corresponding to the target frequency and at a radius `r < 1` (e.g., 0.95) from the origin in the z-plane. This ensures the filters are stable and have a sharp peak in their frequency response around the desired frequency.

For each note frequency:
- The input signal is filtered.
- The output signal’s energy is computed.
- The note corresponding to the filter with the maximum output energy is identified as the detected note.

The function returns:
- The index of the detected note (from 0 to 12).
- The corresponding frequency in hertz.

## Summary
This approach provides a straightforward and effective method for identifying musical notes using frequency-selective filtering and energy analysis.