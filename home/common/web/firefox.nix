{
  pkgs,
  lib,
  inputs,
  system,
  config,
  ...
}:
let
  commonSearch = {
    force = true;
    default = "ddg";
    privateDefault = "ddg";
    order = [
      "ddg"
      "google"
      "kagi"
    ];
    engines = {
      kagi = {
        name = "Kagi";
        urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
        icon = "https://kagi.com/favicon.ico";
      };
      bing.metaData.hidden = true;
    };
  };

  commonExtensions = with inputs.firefox-addons.packages.${system}; [
    ublock-origin
    user-agent-string-switcher
    proton-pass
  ];

  commonBookmarks = { };

  commonSettings = {
    "browser.startup.homepage" = "about:home";

    # Theme
    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "extensions.colorway-builtin-themes-cleanup" = 1;

    # Auto enable extensions
    "extensions.autoDisableScopes" = 0;

    # Disable irritating first-run stuff
    "browser.disableResetPrompt" = true;
    "browser.download.panel.shown" = true;
    "browser.feeds.showFirstRunUI" = false;
    "browser.messaging-system.whatsNewPanel.enabled" = false;
    "browser.rights.3.shown" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;
    "browser.startup.homepage_override.mstone" = "ignore";
    "browser.uitour.enabled" = false;
    "startup.homepage_override_url" = "";
    "trailhead.firstrun.didSeeAboutWelcome" = true;
    "browser.bookmarks.restore_default_bookmarks" = false;
    "browser.bookmarks.addedImportButton" = true;

    # Don't ask for download dir
    "browser.download.useDownloadDir" = true;

    # Disable crappy home activity stream page
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
    "browser.newtabpage.blocked" = lib.genAttrs [
      # Youtube
      "26UbzFJ7qT9/4DhodHKA1Q=="
      # Facebook
      "4gPpjkxgZzXPVtuEoAL9Ig=="
      # Wikipedia
      "eV8/WsSLxHadrTL1gAxhug=="
      # Reddit
      "gLv0ja2RYVgxKdp0I5qwvA=="
      # Amazon
      "K00ILysCaEq8+bEqV/3nuw=="
      # Twitter
      "T9nJot5PurhJSy8n038xGA=="
    ] (_: 1);

    # Disable some telemetry
    "app.shield.optoutstudies.enabled" = false;
    "browser.discovery.enabled" = false;
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.ping-centre.telemetry" = false;
    "datareporting.healthreport.service.enabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "datareporting.sessions.current.clean" = true;
    "devtools.onboarding.telemetry.logged" = false;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.hybridContent.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.prompted" = 2;
    "toolkit.telemetry.rejected" = true;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "toolkit.telemetry.server" = "";
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.unifiedIsOptIn" = false;
    "toolkit.telemetry.updatePing.enabled" = false;

    # Disable fx accounts
    "identity.fxaccounts.enabled" = false;
    # Disable "save password" prompt
    "signon.rememberSignons" = false;
    # Harden
    "privacy.trackingprotection.enabled" = true;
    "dom.security.https_only_mode" = true;

    # # Remove close button
    "browser.tabs.inTitlebar" = 0;
    # Vertical tabs
    "sidebar.verticalTabs" = true;
    "sidebar.revamp" = true;
    "sidebar.main.tools" = [
      "history"
      "bookmarks"
    ];
    "sidebar.expandOnHover" = true;

    # Enabled Unified Extensions
    extensions.unifiedExtensions.enable = true;

    # Enable DRM
    "browser.eme.ui.enabled" = true;
    "media.eme.enabled" = true;

    # Layout
    "browser.uiCustomization.state" = builtins.toJSON {
      "placements" = {
        "widget-overflow-fixed-list" = [ ];
        "unified-extensions-area" = [
          "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
          "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
        ];
        "nav-bar" = [
          "sidebar-button"
          "firefox-view-button"
          "alltabs-button"
          "back-button"
          "forward-button"
          "vertical-spacer"
          "urlbar-container"
          "ublock0_raymondhill_net-browser-action"
          "unified-extensions-button"
        ];
        "toolbar-menubar" = [
          "menubar-items"
        ];
        "TabsToolbar" = [ ];
        "vertical-tabs" = [
          "tabbrowser-tabs"
        ];
        "PersonalToolbar" = [
          "personal-bookmarks"
        ];
      };
      "seen" = [
        "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
        "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
        "ublock0_raymondhill_net-browser-action"
        "developer-button"
        "screenshot-button"
      ];
      "dirtyAreaCache" = [
        "unified-extensions-area"
        "nav-bar"
        "TabsToolbar"
        "vertical-tabs"
        "toolbar-menubar"
        "PersonalToolbar"
      ];
      "currentVersion" = 23;
      "newElementCount" = 0;
    };
  };
in
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = commonSearch;
        bookmarks = commonBookmarks;
        extensions.packages = commonExtensions;
        settings = commonSettings;
      };
      senergy = {
        id = 1;
        name = "senergy";
        isDefault = false;
        search = commonSearch;
        bookmarks = commonBookmarks;
        extensions.packages = commonExtensions;
        settings = commonSettings // {
          "browser.download.dir" = "/home/aodhan/Documents/Senergy/Downloads";
        };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };

  xdg.desktopEntries = lib.mapAttrs' (profileName: profile: {
    name = "firefox-${profileName}";
    value = {
      name = "Firefox (${lib.strings.toUpper (lib.substring 0 1 profile.name)}${
        lib.substring 1 (lib.stringLength profile.name) profile.name
      })";
      comment = "Browse the Web with Firefox ${profile.name} profile";
      exec = "firefox -P ${profile.name} %U";
      icon = "firefox";
      categories = [
        "Network"
        "WebBrowser"
      ];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
  }) config.programs.firefox.profiles;
}
