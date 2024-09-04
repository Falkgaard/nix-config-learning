{ lib, ... }:
{
   i18n = {
      defaultLocale = lib.mkDefault "en_GB.UTF-8";

      extraLocaleSettings = {
         LC_TIME = lib.mkDefault "en_DK.UTF-8";
      };

      supportedLocales = lib.mkDefault [
         "en_GB.UTF-8/UTF-8"
         "en_US.UTF-8/UTF-8"
         # TODO: Swedish & Japanese.
      ];

      location.provider = "geoclue2"; # TODO: Look into alternatives.

      time.timeZone = lib.mkDefault "Europe/Malta";
   };
}
