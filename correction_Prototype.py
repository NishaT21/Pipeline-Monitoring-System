import numpy as np
import matplotlib.pyplot as plt

# Simulation parameters
fs = 48000       # sampling frequency (Hz)
size = 4096      # frequency grid size
f = np.linspace(0, fs/2, size//2)

def pipe_response(frequencies, damping):
    resp = np.zeros_like(f, dtype=float)
    for f0 in frequencies:
        # Resonance curve (Lorentzian / 2nd order system)
        resp += 1 / np.sqrt((f0**2 - f**2)**2 + (2*damping*f0*f)**2)
    return resp

# Healthy pipe: sharp resonances
healthy = pipe_response([8000, 12000, 16000], damping=0.001)

# Corroded pipe: shifted & broader resonances
corroded = pipe_response([7800, 11800, 15800], damping=0.01)

# Normalize for comparison
healthy /= np.max(healthy)
corroded /= np.max(corroded)

# Plot
plt.figure(figsize=(10,6))
plt.plot(f, healthy, label="Healthy Pipe", linewidth=2)
plt.plot(f, corroded, "--", label="Corroded Pipe", linewidth=2)
plt.xlim(5000, 20000)
plt.xlabel("Frequency (Hz)")
plt.ylabel("Normalized Response")
plt.title("Whisper Test Simulation: Healthy vs Corroded Pipe")
plt.legend()
plt.grid(True)
plt.show()
