{
  services.rtorrent = {
    enable = true;
    openFirewall = true;
    configText = ''
      method.redirect=load.throw,load.normal
      method.redirect=load.start_throw,load.start
      method.insert=d.down.sequential,value|const,0
      method.insert=d.down.sequential.set,value|const,0
    '';
  };
}
