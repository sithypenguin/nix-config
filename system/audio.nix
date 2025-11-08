# Audio system configuration
# Configures PipeWire as the audio server, replacing PulseAudio
{ config, pkgs, ... }:

{
    # Disable legacy PulseAudio in favor of PipeWire
    services.pulseaudio.enable = false;             # Disable PulseAudio service
    
    # Real-time kit for better audio performance
    security.rtkit.enable = true;                   # Enable RealtimeKit for low-latency audio
    
    # PipeWire audio server configuration
    services.pipewire = {
        enable = true;                              # Enable PipeWire audio server
        alsa.enable = true;                         # ALSA support for legacy applications
        alsa.support32Bit = true;                   # 32-bit ALSA support for compatibility
        pulse.enable = true;                        # PulseAudio compatibility layer
        
        # Optional JACK support for professional audio applications
        #jack.enable = true;
        
        # Session manager (WirePlumber is now default)
        #media-session.enable = true;
    };
}