@echo off
@title Vivaldi downloader + configer ^| ver.3.2 [10.10.2023]
@cd /d "%~dp0"
@echo.
@echo Release channel:
@echo {R} Release / {S} Snapshot
@choice /c RS
@set ViChan=%ERRORLEVEL%
@set ERRORLEVEL=
@md "VivaldiPortable"
@curl.exe -RLO# "https://www.7-zip.org/a/7zr.exe"
@if not exist "7zr.exe" (@color 0C &@echo DOWNLOAD ERROR: "7zr.exe" &@pause > nul &@exit)

@if /i "%ViChan%"=="2" (@GOTO DLSNA)
@for /f eol^=-^ tokens^=1-26^ delims^=^'^?^" %%a in ('@curl.exe -lsL "https://vivaldi.com/download" ^| 2^>nul FINDSTR /IRC:"vivaldi-versions.js"') do (@set VIVJS=%%e)
@for /f eol^=-^ tokens^=1-26^ delims^=^" %%a in ('@curl.exe -lsL "https://vivaldi.com/wp-content/vivaldi-versions.js?%VIVJS%" ^| 2^>nul FINDSTR /IRC:"version"') do (@set VIVER=%%d)
@echo.Version: "%VIVER%"
@curl.exe -RLO# "https://downloads.vivaldi.com/stable/Vivaldi.%VIVER%.exe"
@curl.exe -RLO# "https://downloads.vivaldi.com/stable/Vivaldi.%VIVER%.x64.exe"
@GOTO DLFIN
:DLSNA
@for /f eol^=-^ tokens^=1-26^ delims^=./^<^>^" %%a in ('@curl.exe -lsL "https://vivaldi.com/feed/" ^| 2^>nul FINDSTR /IRC:"Vivaldi.*.exe"') do (@if NOT DEFINED VIVER (@set VIVER=%%i.%%j.%%k.%%l))
@echo.Version: "%VIVER%"
@curl.exe -RLO# "https://downloads.vivaldi.com/snapshot/Vivaldi.%VIVER%.exe"
@curl.exe -RLO# "https://downloads.vivaldi.com/snapshot/Vivaldi.%VIVER%.x64.exe"
:DLFIN
@if not exist "Vivaldi*.exe" (@color 0C &@echo DOWNLOAD ERROR: "Vivaldi*.exe" &@pause > nul &@exit)

@"7zr.exe" x -t7z -bso0 "Vivaldi.%VIVER%.exe"   	&&@rename "vivaldi.7z" vivaldi32.7z 	&&@"7zr.exe" rn -bso0 "vivaldi32.7z" Vivaldi-bin VivaldiPortable\Vivaldi-bin-win32
@"7zr.exe" x -t7z -bso0 "Vivaldi.%VIVER%.x64.exe" 	&&@rename "vivaldi.7z" vivaldi64.7z 	&&@"7zr.exe" rn -bso0 "vivaldi64.7z" Vivaldi-bin VivaldiPortable\Vivaldi-bin-win64
@"7zr.exe" x -bso0 "vivaldi*.7z" -xr!*default-bookmarks -xr!*sd_thumbnails* -xr!*favicons* -xr!VisualElements
@move VivaldiPortable\Vivaldi-bin-win32\update_notifier.exe VivaldiPortable\Vivaldi-bin-win32\update_notifier.exe.~disabled
@move VivaldiPortable\Vivaldi-bin-win64\update_notifier.exe VivaldiPortable\Vivaldi-bin-win64\update_notifier.exe.~disabled
@del /f /q "Vivaldi.%VIVER%*.exe" "vivaldi*.7z" "7zr.exe"
@CURL -RLO# "https://github.com/czyt/vivaldi_plus/releases/latest/download/windows_x86.zip" &&@tar -xf windows_x86.zip &&@move version.dll "VivaldiPortable\Vivaldi-bin-win32\version.dll"
@CURL -RLO# "https://github.com/czyt/vivaldi_plus/releases/latest/download/windows_x64.zip" &&@tar -xf windows_x64.zip &&@move version.dll "VivaldiPortable\Vivaldi-bin-win64\version.dll"
@del /f /q "windows_x64.zip" "windows_x86.zip"

@type NUL>"VivaldiPortable\Vivaldi-bin-win32\stp.viv"
@type NUL>"VivaldiPortable\Vivaldi-bin-win64\stp.viv"
@md VivaldiPortable\Data\Default
@set cr_loca1={"background_mode":{"enabled":false},"browser":{"enabled_labs_experiments":["ignore-gpu-blocklist","smooth-scrolling@2"]},"hardware_acceleration_mode_previous":true,"profile":{"last_used":"Default"}}
@set cr_pref1={"NewTabPage":{"DisabledModules":["dummy","dummy2"],"ModulesVisible":false},"account_tracker_service_last_update":"13315440277591036","alternate_error_pages":{"backup":false},"announcement_notification_service_first_run_time":"13315440276751720","autocomplete":{"retention_policy_last_version":108},"autofill":{"credit_card_enabled":false,"enabled":false,"orphan_rows_removed":true,"profile_enabled":false},"bookmark_bar":{"show_apps_shortcut":false,"show_on_all_tabs":false,"show_only_on_ntp":true},"browser":{"check_default_browser":false,"clear_data":{"browsing_history_basic":true,"cache_basic":true,"cookies_basic":true,"form_data":true,"hosted_apps_data":true,"media_licenses":true,"passwords":true,"preferences_migrated_to_basic":true,"site_settings":true,"time_period":4,"time_period_basic":4},"clear_lso_data_enabled":true,"has_seen_welcome_page":true,"last_clear_browsing_data_tab":1,"window_placement":{"bottom":720,"left":64,"maximized":true,"right":1200,"top":32}},"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state":2,"download":{"directory_upgrade":true,"prompt_for_download":true},"enable_a_ping":false,"enable_do_not_track":true,"extensions":{"alerts":{"initialized":true},"chrome_url_overrides":{},"commands":{},"ui":{"developer_mode":true}},"first_run_tabs":[],"https_only_mode_enabled":true,"import_bookmarks":false,"import_history":false,"import_home_page":false,"import_search_engine":false,"invalidation":{"per_sender_topics_to_handler":{"1013309121859":{},"8181035976":{}}},"media":{"engagement":{"schema_version":5}},"net":{"network_prediction_options":2},"ntp":{"num_personal_suggestions":0},"omnibox":{"prevent_url_elisions":true},"payments":{"can_make_payment_enabled":false},"plugins":{"plugins_list":[]},"profile":{"avatar_index":24,"block_third_party_cookies":true,"content_settings":{"clear_on_exit_migrated":true,"enable_quiet_permission_ui_enabling_method":{"notifications":1},"exceptions":{},"pref_version":1},"default_content_setting_values":{"background_sync":2,"cookies":1},"exit_type":"Normal","exited_cleanly":true,"local_avatar_index":24,"managed_user_id":"","name":"","password_manager_enabled":false,"were_old_google_logins_removed":true},"safebrowsing":{"enabled":false,"event_timestamps":{}},"search":{"suggest_enabled":false},"settings":{"a11y":{"apply_page_colors_only_on_increased_contrast":true}},"signin":{"allowed":false},"spellcheck":{"dictionaries":["ru"],"dictionary":""},"translate":{"enabled":false},"unified_consent":{"migration_state":10},"vivaldi":{"address_bar":{"extensions":{"hidden_extensions":[],"render_in_dropdown":true,"show_all_toggle":true},"highlight_base_domain":true,"omnibox":{"show_top_sites":false},"search":{"display":1,"show_favicon":true,"suggest_enabled":false},"show_full_url":true,"show_profile":false,"show_qr_generator":true,"visible":true},"appearance":{"css_ui_mods_directory":"CSS","range_buttons":true},"bookmarks":{"language":"uk-UA","panel":{"sorting":{"sortField":"manually","sortOrder":1}}},"chained_commands":{"command_list":[],"deleted_command_list":[],"version":1},"downloads":{"start_automatically":false},"experiments":["css_mods","custom_buttons"],"homepage":"vivaldi://startpage","homepage_cache":"","incognito":{"show_intro":false},"language_at_install":"ru","menu":{"display":0,"icon_type":1},"panels":{"web":{"elements":[],"removed_elements":[{"id":"WEBPANEL_949d4873-deed-4168-b306-92d1848687a5","mobileMode":true,"title":"","url":"https://social.vivaldi.net/","zoom":1},{"id":"WEBPANEL_ckmam0bsw00002y5xoafpww5i","mobileMode":true,"origin":"bundle","resizable":false,"title":"","url":"https://help.vivaldi.com/","width":-1,"zoom":1},{"id":"WEBPANEL_ckn7fhhqx0000hc2roo8jshm4","mobileMode":true,"origin":"bundle","resizable":false,"title":"","url":"https://wikipedia.org","width":-1,"zoom":1}]},"window_defaults":{"barVisible":false,"panelVisible":false,"selectedPanel":"PanelDownloads","width":310}},"popups":{"show_in_tab":true},"privacy":{"adverse_ad_block":{"last_update":"2022-12-13T22:32:32.883Z"},"google_component_extensions":{"hangout_services":false}},"settings":{"in_tab":true,"mono_icons":false},"show_extensions_banner":false,"startpage":{"navigation":2,"speed_dial":{"add_button_visible":false,"display_search":false,"game_button_show":false,"privacy_stats_show":false}},"startup":{"check_is_default":false,"has_seen_feature":1},"status_bar":{"display":2,"minimized":1},"system":{"desktop_theme_color":0,"show_exit_confirmation_dialog":false},"tabs":{"active_min_size":30,"cycle_by_recent_order":false,"dim_hibernated":true,"horizontal_scrolling":false,"show_synced_tabs_button":false,"show_trash_can":true,"stacking":{"allow_dnd":true,"dnd_delay":50,"mode":3,"open_accordions":[]}},"theme":{"dim_blurred":false,"schedule":{"enabled":0,"o_s":{"dark":"Vivaldi2","light":"Vivaldi5"}},"simple_scrollbar":false,"use_animation":false},"themes":{"current":"Vivaldi5"},"toolbars":{"navigation":["Back","Forward","Reload","AddressField","UpdateButton","Extensions"],"panel":["PanelBookmarks","PanelReadingList","PanelDownloads","PanelHistory","PanelNotes","PanelWindow","PanelTranslate","PanelMail","PanelCalendar","PanelTasks","PanelFeeds","PanelContacts","PanelWeb","FlexibleSpacer","Settings"],"status":["PanelToggle","BreakMode","SyncStatus","MailStatus","CalendarStatus","StatusInfo","VersionInfo","CaptureImages","TilingToggle","ImagesToggle","PageActions","Zoom"]},"translate":{"enabled":false},"webpages":{"smooth_scrolling":{"enabled":false}},"welcome":{"read_pages":["welcome_four","import_data","tracker_and_ad","personalize","tabs","touch"],"seen_pages":["welcome_four","import_data","tracker_and_ad","personalize","tabs","touch"]},"windows":{"show_window_close_confirmation_dialog":false},"workspaces":{"button":{"show_in_tabbar":true,"show_name":true},"enabled":false}}}
(@echo %cr_loca1%)>"VivaldiPortable\Data\Local State"
(@echo %cr_pref1%)>"VivaldiPortable\Data\Default\Preferences"

@md "VivaldiPortable\Vivaldi-bin-win32\%VIVER%\CSS\"
@md "VivaldiPortable\Vivaldi-bin-win64\%VIVER%\CSS\"
(
@echo #browser:not^(.tabs-top^) .vivaldi { height:30px; padding:0; }
@echo #browser.win.win10.tabs-top #header #titlebar .window-buttongroup button:not^(.vivaldi^) { height:unset; }
@echo #header { height:unset; }
@echo #header, #main { position:unset; }
@echo #main { position:unset; }
@echo #main ^> div.mainbar ^> div ^> div.toolbar-extensions { position:absolute !important; transform:translate^(-100%%, 0^); background-color:var^(--colorAccentBg^) !important; transition:background-color 0.7s ease-out; left:calc^(100vw - 172px^) !important; height:30px !important; right:unset !important; top:0px; border-radius:var^(--radiusHalf^)!important; }
@echo #tabs-container .resize { min-height:30px; margin-top:0px; }
@echo #tabs-container:not^(.none^).top { padding-left:calc^(30vw + 184px^) !important; padding-right:170px !important; padding-top:0px !important; margin-top:0px; min-height:30px; transition:0.3s; }
@echo .color-behind-tabs-on#browser.tabs-top #header { transition:0.7s ease-out; }
@echo .tab-group-indicator { top:0 !important; }
@echo .tab-position .tab { display:flex; flex:1 1 100%%; flex-flow:column; overflow:hidden; font-size:11px; -webkit-user-select:none; -webkit-user-drag:element; }
@echo .tabs-right#browser.win.win10 .tabs-bottom#browser.win.win10 .tabs-left#browser.win.win10, #browser.win.win10 #header #titlebar .window-buttongroup button { height:30px; }
@echo .tabs-at-edge.fullscreen#browser.win.win10.tabs-top #header #titlebar .window-buttongroup button:not^(.vivaldi^), .tabs-at-edge.maximized#browser.win.win10.tabs-top #header #titlebar .window-buttongroup button:not^(.vivaldi^) { height:30px; }
@echo .maximized#browser:has^(#tabs-subcontainer.top^) .toolbar-mainbar:not^(.toolbar-wrap^):not^( .toolbar-editor section.dialog-preview .toolbar^):not^(.toolbar.toolbar-droptarget.toolbar-mainbar.toolbar-mailbar.toolbar-large^) { transform:translateY^(-60px^); }
@echo .toolbar-mainbar .toolbar-extensions ^> .button-toolbar ^> button { height:30px; }
@echo .toolbar-mainbar .toolbar-extensions { background-color:transparent; }
@echo .toolbar-mainbar .toolbar-extensions:after, .toolbar-mainbar:after { display:none !important; }
@echo .toolbar-mainbar ^> .button-toolbar ^> button { height:30px; }
@echo .toolbar-mainbar { background:linear-gradient^(rgba^(0, 0, 0, 0.2^),rgba^(0, 0, 0, 0.2^)^), var^(--colorAccentBgDarker^); transition:background-color 0.7s ease-out; }
@echo .toolbar-mainbar { background:transparent; border-radius:var^(--radiusHalf^); }
@echo .toolbar-mainbar:not^(.toolbar-wrap^):not^( .toolbar-editor section.dialog-preview .toolbar^):not^(.toolbar.toolbar-droptarget.toolbar-mainbar.toolbar-mailbar.toolbar-large^) { position:absolute; top:unset;  left:35px !important; height:30px; background:var^(--colorAccentBg^) !important; border:none !important; transform:translateY^(-30px^); }
@echo .toolbar-tabbar.sync-and-trash-container { top:0px !important; }
@echo .toolbar.toolbar-droptarget.toolbar-mainbar.toolbar-mailbar.toolbar-large { width:100vw; left:0px; }
@echo .maximized#browser:has^(.toolbar-mailbar.toolbar-large^) #tabs-container:not^(.none^).top { padding-left:35px !important; }
@echo .maximized#browser:has^(.toolbar-mailbar.toolbar-large^) .mainbar { top:unset; position:relative; }
@echo .UrlBar-AddressField { width:31vw !important; top:0px !important; }
@echo .UrlBar-PrivateWindowIndicator { font-size:0; padding:0 6px 0 6px; }
@echo .maximized#browser:has^(.UrlBar-PrivateWindowIndicator^) #tabs-container:not^(.none^).top { padding-left:calc^(30vw + 184px^) !important; }
@echo .vivaldi { margin-top:-6px !important; }
@echo .vivaldi { margin-top:0px !important; }
@echo .win #titlebar #pagetitle ^> span, .linux #titlebar #pagetitle ^> span { text-align:left; margin-left:38%%; width:42vw; }
@echo .win.normal #titlebar { top:0px; }
@echo .win.normal .toolbar-mainbar { left:unset; right:unset; border-radius:var^(--radiusHalf^)!important; }
@echo .win.normal .UrlBar-AddressField { top:0px; }
@echo .win10.normal #tabs-tabbar-container.top { padding-top:6px; }
@echo .maximized .win10.normal #tabs-tabbar-container.top { padding-top:0px !IMPORTANT; }
@echo .window-buttongroup { height:unset !important; width:unset !important; top:0px !important; }
@echo #browser, #browser + div, #browser + div + div, #browser button, #browser input, #browser select, #browser textarea { font-family:Arial,Tahoma,'MS Sans Serif','Segoe UI',system-ui,sans-serif !important; font-weight:400; font-size:11px; line-height:1.0; }
)>"VivaldiPortable\Vivaldi-bin-win32\%VIVER%\CSS\custom.css"
@copy "VivaldiPortable\Vivaldi-bin-win32\%VIVER%\CSS\custom.css" "VivaldiPortable\Vivaldi-bin-win64\%VIVER%\CSS\custom.css"

(@echo @start Vivaldi.exe --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --disable-background-networking --disable-component-update --no-default-browser-check)>"VivaldiPortable\Vivaldi-bin-win32\VivaldiLauncher.bat"
(@echo @start Vivaldi.exe --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --disable-background-networking --disable-component-update --no-default-browser-check)>"VivaldiPortable\Vivaldi-bin-win64\VivaldiLauncher.bat"

@echo Done!
@pause > nul