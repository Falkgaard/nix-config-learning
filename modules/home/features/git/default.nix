# ./modules/home/features/git/default.nix
{
   inputs,
   ...
}:{
   programs.git = {
      enable    = true;
      userEmail = "falkgaard@falkgaard.com";
      userName  = "falkgaard";
   };
} # end-of: <module>

