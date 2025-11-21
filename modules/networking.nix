{ config, pkgs, ... } : {

#networking
  networking = {
    hostName = "Cyclops"; # Define your hostname.
      networkmanager.enable = false;
    useNetworkd = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80    #HTTP
          443   #HTTPS
          22    #SSH
      ];
    };
  };

  networking.wireless.iwd.enable = true;
  services.dbus.enable = true;

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
    enable = true;
    passwordAuthentication = false;
    useDns = true;
    permitRootLogin = "no";
  };

                        }
