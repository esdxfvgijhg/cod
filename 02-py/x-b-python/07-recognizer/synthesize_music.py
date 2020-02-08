#!/usr/bin/python
import json
import numpy as np
from scipy.io.wavfile import write
import matplotlib.pyplot as plt


def synthesizer(freq, duration, amp=1.0, sampling_freq=44100):  # Synthesize tone
    t = np.linspace(0, duration, duration * sampling_freq)  # Build the time axis
    audio = amp * np.sin(2 * np.pi * freq * t)  # Construct the audio signal
    return audio.astype(np.int16)


if __name__ == "__main__":
    tone_map_file = "tone_freq_map.json"  # Input file containing note to frequency mapping
    with open(tone_map_file, "r") as f:  # Read the frequency map
        tone_freq_map = json.loads(f.read())
    input_tone = "G"  # Set input parameters to generate 'G' tone
    duration = 2  # seconds
    amplitude = 10000
    sampling_freq = 44100  # Hz
    synthesized_tone = synthesizer(tone_freq_map[input_tone], duration, amplitude, sampling_freq)  # Generate the tone
    write("output_tone.wav", sampling_freq, synthesized_tone)  # Write to the output file
    tone_seq = [("D", 0.3), ("G", 0.6), ("C", 0.5), ("A", 0.3), ("Asharp", 0.7)]  # Tone-duration sequence
    output = np.array([])  # Construct the audio signal based on the chord sequence
    for item in tone_seq:
        input_tone = item[0]
        duration = item[1]
        synthesized_tone = synthesizer(tone_freq_map[input_tone], duration, amplitude, sampling_freq)
        output = np.append(output, synthesized_tone, axis=0)
    write("output_tone_seq.wav", sampling_freq, output)  # Write to the output file
