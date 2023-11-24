{ pkgs, inputs, ... }:

{
    programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      settings = {
        "browser.startup.homepage" = "about:blank";
      };
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        darkreader
        ublock-origin
      ];
      bookmarks = [
        {
          name = "YouTube";
          url = "www.youtube.com";
        }
        {
          name = "YouTube Music";
          url = "www.music.youtube.com";
        }
        {
          name = "Calendar";
          url = "calendar.google.com";
        }
        {
          name = "Google Drive";
          url = "drive.google.com";
        }
        {
          name = "Deepl Translate";
          url = "www.deepl.com/es/translator";
        }
        {
          name = "Home-manager bible";
          url = "https://rycee.gitlab.io/home-manager/options.html";
        }
      ];
    };
  };
}
