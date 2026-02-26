# Pipeline-Monitoring-System
Pipeline Monitoring System – Acoustic Leak &amp; Corrosion Detection: Developed a low-cost acoustic monitoring system using a 16-microphone circular array with GCC-PHAT-based TDOA for 360° leak localization. Performed resonance shift analysis to detect corrosion, validated using MATLAB/Simulink under noisy conditions.

## Overview

<p style="font-size:18px;">
Pipelines are critical to modern infrastructure, transporting essential resources such as water, oil, and gas. However, leaks, corrosion, buried faults, and gas emissions often remain undetected, leading to costly failures, safety risks, and environmental damage. Conventional inspection methods such as ultrasonic testing, radiography, and ground penetrating radar are expensive, intrusive, and not suitable for continuous monitoring.

This project proposes a low cost, portable, real time acoustic monitoring system designed to detect leaks, corrosion, and hidden structural anomalies in pipelines using advanced signal processing techniques.
</p>

# Acoustic Holography Flex-Array -Leak Detection Simulation
## 🔧 What Was Done

- Designed a **16-microphone circular array model** with configurable radius and sampling rate  
- Generated **broadband bandpass filtered leak signals (2–20 kHz)**  
- Simulated **direction-dependent propagation delays** based on array geometry  
- Implemented **GCC-PHAT algorithm** for robust time delay estimation  
- Estimated leak direction using **orthogonal microphone pairs (0°–180° and 90°–270°)**  
- Computed source angle using **TDOA-derived cosine and sine components**  
- Visualized **true vs. estimated leak direction** using polar plots  

## 🛠️ Tools Used

- **GNU Octave / MATLAB**  
- **Signal Processing Package** (`butter`, `filter`, `FFT`)  
- **GCC-PHAT Algorithm** for time delay estimation  
- **TDOA-Based Angle Estimation**  
- **Circular Microphone Array Modeling**

## ⚠️ Scope & Limitations

- Simulation-based validation only (no physical hardware implementation)  
- Uses integer-sample delay approximation (no fractional delay modeling)  
- Assumes ideal acoustic environment without multipath reflections  
- Noise robustness not fully evaluated under varying SNR conditions  
- Leak source modeled as broadband white noise (real leak signatures may differ)

# 🎧 Whisper Test – Pipe Corrosion Detection Simulation

This project simulates acoustic resonance behavior of healthy and corroded pipelines using frequency-domain modeling.  
The goal is to observe how corrosion affects structural resonance characteristics such as peak shift and damping increase.

## 🔧 What Was Done

- Modeled pipe acoustic response using a **multi-resonance Lorentzian system**
- Simulated **healthy pipe resonances** with sharp, narrowband peaks
- Simulated **corroded pipe response** with frequency shifts and increased damping
- Compared resonance broadening and peak shifts due to structural degradation
- Normalized spectral responses for direct comparison
- Visualized healthy vs. corroded frequency responses

## 🛠️ Tools Used

- **Python**
- **NumPy**
- **Matplotlib**
- Frequency-domain resonance modeling
- Structural damping simulation

## ⚠️ Scope & Limitations

- Simulation-based validation only
- Uses simplified second-order resonance approximation
- Does not include nonlinear structural effects
- No environmental noise or multipath reflections modeled
- Real corrosion patterns may exhibit more complex acoustic signatures
