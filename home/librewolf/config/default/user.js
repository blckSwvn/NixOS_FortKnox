//dont work with RFP
// user_pref("ui.systemUsesDarkTheme", 1);
// user_pref("browser.theme.system_theme", false);
user_pref("browser.fullscreen.autohide", false);
user_pref("privacy.resistFingerprinting.spoofOsInUserAgentHeader", false); //bugy as hell

user_pref("browser.toolbars.bookmarks.visibility", "never");

user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
// user_pref("privacy.resistFingerprinting.letterboxing", true)

// Force HTTPS
user_pref("dom.security.https_only_mode", true);

// Strong site isolation
user_pref("privacy.firstparty.isolate", true);

// Total cookie isolation
user_pref("network.cookie.cookieBehavior", 5);

// Block WebRTC (IP leak prevention)
user_pref("media.peerconnection.enabled", false);

// **DO NOT explicitly disable WebGL / canvas / WebAudio**
// Let RFP spoof/normalize these instead of making your browser rare.
// If you currently have these enabled in your file, comment them out:
 // user_pref("webgl.disabled", true);
 // user_pref("canvas.poisondata", true);
 // user_pref("dom.webaudio.enabled", false);

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

// Disable Web Audio fingerprinting, fingerprints in of itself
// user_pref("dom.webaudio.enabled", false);

// Disable battery API
user_pref("dom.battery.enabled", false);

// Reduce timing precision (helps against timing attacks)
user_pref("privacy.reduceTimerPrecision", true);
user_pref("privacy.reduceTimerPrecision.jitter", 50);

// Disable resource and performance timing APIs
user_pref("dom.enable_performance", false);
user_pref("dom.enable_resource_timing", false);
user_pref("dom.enable_user_timing", false);

// Telemetry and data reporting
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.aboutHomeSnippets.updateUrl", "");
