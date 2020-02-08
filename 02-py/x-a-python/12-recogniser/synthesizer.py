#!/usr/bin/python
import json
import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import write


def tone_synthesizer(freq, duration, amplitude=1.0, sampling_freq=44100):  # Synthesize the tone based on the input parameters
    time_axis = np.linspace(0, duration, duration * sampling_freq)  # Construct the time axis
    signal = amplitude * np.sin(2 * np.pi * freq * time_axis)  # Construct the audio signal
    return signal.astype(np.int16)


if __name__ == "__main__":
    file_tone_single = "generated_tone_single.wav"  # Names of output files
    file_tone_sequence = "generated_tone_sequence.wav"
    mapping_file = "tone_mapping.json"  # Source: http://www.phy.mtu.edu/~suits/notefreqs.html
    with open(mapping_file, "r") as f:  # Load the tone to frequency map from the mapping file
        tone_map = json.loads(f.read())
    tone_name = "F"  # Set input parameters to generate 'F' tone
    duration = 3  # seconds
    amplitude = 12000
    sampling_freq = 44100  # Hz
    tone_freq = tone_map[tone_name]  # Extract the tone frequency
    synthesized_tone = tone_synthesizer(tone_freq, duration, amplitude, sampling_freq)  # Generate the tone using the above parameters
    write(file_tone_single, sampling_freq, synthesized_tone)  # Write the audio signal to the output file
    tone_sequence = [("G", 0.4), ("D", 0.5), ("F", 0.3), ("C", 0.6), ("A", 0.4)]  # Define the tone sequence along with corresponding durations in seconds
    signal = np.array([])  # Construct the audio signal based on the above sequence
    for item in tone_sequence:
        tone_name = item[0]  # Get the name of the tone
        freq = tone_map[tone_name]  # Extract the corresponding frequency of the tone
        duration = item[1]  # Extract the duration
        synthesized_tone = tone_synthesizer(freq, duration, amplitude, sampling_freq)  # Synthesize the tone
        signal = np.append(signal, synthesized_tone, axis=0)  # Append the output signal
    write(file_tone_sequence, sampling_freq, signal)  # Save the audio in the output file
