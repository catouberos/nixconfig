{inputs, ...}: {
  # overlays
  modifications = final: prev: {
    tauon = prev.tauon.override {withDiscordRPC = true;};
  };
}
