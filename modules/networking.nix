{ config, pkgs, ... } : {

#networking
networking = {
  hostName = "Cyclops"; # Define your hostname.
  networkmanager.enable = true;
  firewall = {
    enable = true;
    allowedTCPPorts = [
    #3478  #TDP
    80    #HTTP
    443   #HTTPS
    51820 #WireGuard
    #22    #SSH
    #53    #DNS
    ];
  };
};

#Fail2ban
services.fail2ban = {
  enable = true;
  maxretry = 5;
  ignoreIP = [
  ];
  bantime = "24h";
  bantime-increment = {
    enable = true; # Enable increment of bantime after each violation
    formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
    maxtime = "168h";
    overalljails = true; # Calculate the bantime based on all the violations
  };
};

#SSH
services.openssh = {
  enable = false;
  passwordAuthentication = false;
  useDns = true;
  permitRootLogin = "no";
};

}
