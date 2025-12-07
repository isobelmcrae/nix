{ config, pkgs, ... }:

let
  lock_false = {
    Value = false;
    Status = "locked";
  };
  lock_true = {
    Value = true;
    Status = "locked";
  };

  latestExtensionSourceURL =
    name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
in
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFormHistory = true;

      # disable firefox chatbots & other generative ai
      GenerativeAI = {
        Enabled = false;
        Locked = true;
      };

      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";

      # Extensions
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = latestExtensionSourceURL "ublock-origin";
          installation_mode = "force_installed";
        };

        # used for rose-pine firefox theme
        # https://github.com/rose-pine/firefox
        "FirefoxColor@mozilla.com" = {
          install_url = latestExtensionSourceURL "firefox-color";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
        # enable vertical tabs
        "sidebar.verticalTabs" = lock_true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = lock_true;

        # dark mode
        "layout.css.prefers-color-scheme.content-override" = {
          Value = 0; # dark mode
          Locked = true;
        };

        # remove half the stuff from new tab page
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock_false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock_false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock_false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock_false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock_false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock_false;

        # remove sponsors from new tab page
        "browser.newtabpage.activity-stream.showSponsored" = lock_false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock_false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock_false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = lock_false;
      };
    };
  };
}
