# TODO: Replace instances of `falk` with something akin to `${username}`?
{ pkgs, config, lib, ... }:
let
   # Helper function:
   ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups; # TODO: Grok & Explain.
in {
   users.mutableUsers = false; # TODO: Grok & Explain.

   users.users.falk = {
      isNormalUser = true;
      shell        = pkgs.fish;
      extraGroups  = ifTheyExist [
         "audio"
         "git"
         "network"
         "video"
         "wheel"
         # NOTE: Add more if needed.
      ];
      ## TODO!
      #openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../home/users/falk/data/ssh.pub);
      #hashedPasswordFile = config.sops.secrets.falk-password.path;
      packages = [ pkgs.home-manager ];
   };

   ## TODO!
   #sops.secrets.falk-password = {
   #   sopsFile       = ../home/user.profiles/falk/data/secrets.yaml;
   #   neededForUsers = true;
   #};

   home-manager.users.falk = # TODO: Verify using a string is OK.
      import ../home/user-config-suites/falk/user-config-instances/${config.networking.hostName}.nix;

   # TODO: security.pam.sevices?
}
