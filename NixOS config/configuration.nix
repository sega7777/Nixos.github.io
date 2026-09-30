# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 10;};

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
  	General = {
  	  Enable = "Source,Sink,Media,Socket";
  	  Experimental = true;
  	};
  }; 

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."sega" = {
    isNormalUser = true;
    description = "sega";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable fish shell.
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
  				  set fish_greeting
  				'';
  programs.fish.vendor.functions.enable = true;
  programs.fish.vendor.completions.enable = true;
  programs.fish.vendor.config.enable = true;
  programs.fish.extraCompletionPackages = [ ];
  programs.fish.generateCompletions = true;
  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # create a  nix flake
#   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # If set to true, Nix automatically detects files in the store that have identical
  #  content, and replaces them with hard links to a single copy
  nix.settings.auto-optimise-store = true;
  

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
	environment.systemPackages = with pkgs; [
adapta-gtk-theme
alacritty
alacritty-theme
amber-theme
andromeda-gtk-theme
ant-bloody-theme
ant-nebula-theme
ant-theme
arc-icon-theme
arc-theme
arandr
avahi
baobab
beauty-line-icon-theme
bibata-cursors
brave
btop
candy-icons
catfish
catppuccin-cursors
catppuccin-gtk
curl
dconf-editor
deadbeef-with-plugins
dejavu_fonts
drawio
dracula-icon-theme
dracula-theme
duf
evince
faba-icon-theme
feh
file-roller
fish
fishPlugins.fzf-fish
fishPlugins.tide
flameshot
font-manager
fzf
galculator
gcolor3
ghostty
git
gnome-disk-utility
gparted
gruvbox-dark-gtk
gruvbox-dark-icons-gtk
gruvbox-gtk-theme
hack-font
hardinfo2
inetutils
joplin-desktop
kora-icon-theme
la-capitaine-icon-theme
liberation_ttf
libreoffice-fresh
lolcat
lsb-release
lshw
magnetic-catppuccin-gtk
marwaita
meld
menulibre
micro-full
moka-icon-theme
nordic
nordzy-icon-theme
noto-fonts
numix-gtk-theme
numix-icon-theme
numlockx
papirus-icon-theme
paper-gtk-theme
paper-icon-theme
pavucontrol
plano-theme
platinum-searcher
polkit_gnome
qogir-icon-theme
qogir-theme
ristretto
ripgrep
roboto
roboto-mono
rofi
rofi-bluetooth
rofi-calc
rofi-file-browser
rofi-emoji
rofi-nerdy
rofi-network-manager
rofi-screenshot
rofi-unwrapped
shortwave
standardnotes
stilo-themes
tela-icon-theme
tokyonight-gtk-theme
ubuntu-themes
vim
vivaldi
vivaldi-ffmpeg-codecs
vlc
vscode
wget
xcolor
xfce4-clipman-plugin
xfce4-cpufreq-plugin
xfce4-cpugraph-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-sensors-plugin
xfce4-systemload-plugin
xfce4-time-out-plugin
xfce4-weather-plugin
xfce4-whiskermenu-plugin
xfwm4-themes
xkill
zuki-themes
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
