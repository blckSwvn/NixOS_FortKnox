user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.theme.system_theme", false);

user_pref("browser.fullscreen.autohide", false);

user_pref("browser.toolbars.bookmarks.visibility", "never");

//necesarry evil for useragent overide
user_pref("privacy.resistFingerprinting", false);
user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:115.0) Gecko/20100101 Firefox/115.0");

// Force HTTPS
user_pref("dom.security.https_only_mode", true);

// Strong site isolation
user_pref("privacy.firstparty.isolate", true);

// Total cookie isolation
user_pref("network.cookie.cookieBehavior", 5);

// Block WebRTC (IP leak prevention)
user_pref("media.peerconnection.enabled", false);

// Disable WebGL (common fingerprint vector)
user_pref("webgl.disabled", true);
user_pref("canvas.poisondata", true);

// Disable geolocation, sensors, and push
user_pref("geo.enabled", false);
user_pref("device.sensors.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.webnotifications.enabled", false);

// Disable speculative/pre-fetch connections
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("browser.urlbar.speculativeConnect.enabled", false);

/*** UX minimalism ***/

// No session restore
user_pref("browser.startup.page", 0);

// Blank new tab
user_pref("browser.newtabpage.enabled", false);

// No pocket, DRM, or media autoplay
user_pref("extensions.pocket.enabled", false);
user_pref("media.eme.enabled", false);
user_pref("media.autoplay.default", 5);

// Compact UI
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);
