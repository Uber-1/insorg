@echo off
@title Vivaldi downloader + configer ^| ver.1.2 [25.04.2023]
@cd /d "%~dp0"

@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://downloads.vivaldi.com/stable/Vivaldi.5.6.2867.62.exe', 'Vivaldi.5.6.2867.62.exe')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://downloads.vivaldi.com/stable/Vivaldi.5.6.2867.62.x64.exe', 'Vivaldi.5.6.2867.62.x64.exe')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe', '7zr.exe')"
@"7zr.exe" x -t7z -bso0 "Vivaldi.5.6.2867.62.exe"   	&&@rename "vivaldi.7z" vivaldi32.7z 	&&@"7zr.exe" rn -bso0 "vivaldi32.7z" Vivaldi-bin Vivaldi-bin-win32
@"7zr.exe" x -t7z -bso0 "Vivaldi.5.6.2867.62.x64.exe" 	&&@rename "vivaldi.7z" vivaldi64.7z 	&&@"7zr.exe" rn -bso0 "vivaldi64.7z" Vivaldi-bin Vivaldi-bin-win64
@"7zr.exe" x -bso0 "vivaldi*.7z" -xr!*default-bookmarks -xr!*sd_thumbnails* -xr!*favicons* -xr!VisualElements
@move Vivaldi-bin-win32\update_notifier.exe Vivaldi-bin-win32\update_notifier.exe.~disabled
@move Vivaldi-bin-win64\update_notifier.exe Vivaldi-bin-win64\update_notifier.exe.~disabled
@del /f /q "Vivaldi.5.6.2867.62*.exe" "vivaldi*.7z" "7zr.exe"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/jestxfot/Google-Chrome-Portable/releases/download/1.5.4.2/version32.dll', 'Vivaldi-bin-win32\version.dll')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/jestxfot/Google-Chrome-Portable/releases/download/1.5.4.2/version64.dll', 'Vivaldi-bin-win64\version.dll')"

@type NUL>"Vivaldi-bin-win32\stp.viv"
@type NUL>"Vivaldi-bin-win64\stp.viv"
@md Data\Default
@set cr_loca1={"background_mode":{"enabled":false},"browser":{"enabled_labs_experiments":["ignore-gpu-blocklist","smooth-scrolling@2"]},"hardware_acceleration_mode_previous":true,"profile":{"last_used":"Default"}}
@set cr_pref1={"NewTabPage":{"DisabledModules":["dummy","dummy2"],"ModulesVisible":false},"account_tracker_service_last_update":"13315440277591036","alternate_error_pages":{"backup":false},"announcement_notification_service_first_run_time":"13315440276751720","autocomplete":{"retention_policy_last_version":108},"autofill":{"credit_card_enabled":false,"enabled":false,"orphan_rows_removed":true,"profile_enabled":false},"bookmark_bar":{"show_apps_shortcut":false,"show_on_all_tabs":false,"show_only_on_ntp":true},"browser":{"check_default_browser":false,"clear_data":{"browsing_history_basic":true,"cache_basic":true,"cookies_basic":true,"form_data":true,"hosted_apps_data":true,"media_licenses":true,"passwords":true,"preferences_migrated_to_basic":true,"site_settings":true,"time_period":4,"time_period_basic":4},"clear_lso_data_enabled":true,"has_seen_welcome_page":true,"last_clear_browsing_data_tab":1,"window_placement":{"bottom":720,"left":64,"maximized":true,"right":1200,"top":32,"work_area_bottom":994,"work_area_left":0,"work_area_right":1280,"work_area_top":0}},"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state":2,"download":{"directory_upgrade":true,"prompt_for_download":true},"enable_a_ping":false,"enable_do_not_track":true,"extensions":{"alerts":{"initialized":true},"chrome_url_overrides":{},"commands":{},"ui":{"developer_mode":true}},"first_run_tabs":[],"https_only_mode_enabled":true,"import_bookmarks":false,"import_history":false,"import_home_page":false,"import_search_engine":false,"invalidation":{"per_sender_topics_to_handler":{"1013309121859":{},"8181035976":{}}},"media":{"engagement":{"schema_version":5}},"net":{"network_prediction_options":2},"ntp":{"num_personal_suggestions":0},"omnibox":{"prevent_url_elisions":true},"payments":{"can_make_payment_enabled":false},"plugins":{"plugins_list":[]},"profile":{"avatar_index":24,"block_third_party_cookies":true,"content_settings":{"clear_on_exit_migrated":true,"enable_quiet_permission_ui_enabling_method":{"notifications":1},"exceptions":{},"pref_version":1},"default_content_setting_values":{"background_sync":2,"cookies":1},"exit_type":"Normal","exited_cleanly":true,"local_avatar_index":24,"managed_user_id":"","name":"","password_manager_enabled":false,"were_old_google_logins_removed":true},"safebrowsing":{"enabled":false,"event_timestamps":{}},"search":{"suggest_enabled":false},"settings":{"a11y":{"apply_page_colors_only_on_increased_contrast":true}},"signin":{"allowed":false},"spellcheck":{"dictionaries":["ru"],"dictionary":""},"translate":{"enabled":false},"unified_consent":{"migration_state":10},"vivaldi":{"address_bar":{"extensions":{"hidden_extensions":[],"render_in_dropdown":true,"show_all_toggle":true},"search":{"display":1,"show_favicon":true},"show_full_url":true,"show_profile":false,"show_qr_generator":true},"appearance":{"css_ui_mods_directory":"CSS","range_buttons":true},"bookmarks":{"language":"uk-UA","panel":{"sorting":{"sortField":"manually","sortOrder":1}}},"chained_commands":{"command_list":[],"deleted_command_list":[],"version":1},"downloads":{"start_automatically":false},"experiments":["css_mods","custom_buttons"],"homepage":"vivaldi://startpage","homepage_cache":"","incognito":{"show_intro":false},"language_at_install":"ru","menu":{"display":0},"panels":{"web":{"elements":[],"removed_elements":[{"id":"WEBPANEL_949d4873-deed-4168-b306-92d1848687a5","mobileMode":true,"title":"","url":"https://social.vivaldi.net/","zoom":1},{"id":"WEBPANEL_ckmam0bsw00002y5xoafpww5i","mobileMode":true,"origin":"bundle","resizable":false,"title":"","url":"https://help.vivaldi.com/","width":-1,"zoom":1},{"id":"WEBPANEL_ckn7fhhqx0000hc2roo8jshm4","mobileMode":true,"origin":"bundle","resizable":false,"title":"","url":"https://wikipedia.org","width":-1,"zoom":1}]},"window_defaults":{"barVisible":false,"panelVisible":false,"selectedPanel":"PanelDownloads","width":310}},"popups":{"show_in_tab":true},"privacy":{"adverse_ad_block":{"last_update":"2022-12-13T22:32:32.883Z"},"google_component_extensions":{"hangout_services":false}},"settings":{"in_tab":true,"mono_icons":false,"size":{"height":994,"left":0,"top":0,"width":1280}},"show_extensions_banner":false,"startpage":{"navigation":2,"speed_dial":{"add_button_visible":false,"display_search":false,"game_button_show":false,"privacy_stats_show":false}},"startup":{"check_is_default":false,"has_seen_feature":1},"system":{"desktop_theme_color":0,"show_exit_confirmation_dialog":false},"tabs":{"cycle_by_recent_order":false,"stacking":{"allow_dnd":true,"dnd_delay":50,"mode":3,"open_accordions":[]}},"theme":{"dim_blurred":false,"schedule":{"enabled":0,"o_s":{"dark":"Vivaldi2","light":"Vivaldi5"}},"simple_scrollbar":false,"use_animation":false},"toolbars":{"navigation":["Back","Forward","Reload","AddressField","UpdateButton","Extensions"],"panel":["PanelBookmarks","PanelReadingList","PanelDownloads","PanelHistory","PanelNotes","PanelWindow","PanelTranslate","PanelMail","PanelCalendar","PanelTasks","PanelFeeds","PanelContacts","PanelWeb","FlexibleSpacer","Settings"],"status":["PanelToggle","BreakMode","SyncStatus","MailStatus","CalendarStatus","StatusInfo","VersionInfo","CaptureImages","TilingToggle","ImagesToggle","PageActions","Zoom"]},"translate":{"enabled":false},"webpages":{"smooth_scrolling":{"enabled":false}},"welcome":{"read_pages":["welcome_four","import_data","tracker_and_ad","personalize","tabs","touch"],"seen_pages":["welcome_four","import_data","tracker_and_ad","personalize","tabs","touch"]},"windows":{"show_window_close_confirmation_dialog":false}}}
(@echo %cr_loca1%)>"Data\Local State"
(@echo %cr_pref1%)>"Data\Default\Preferences"

(@echo @start Vivaldi.exe --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --disable-background-networking --disable-component-update --no-default-browser-check)>"Vivaldi-bin-win32\VivaldiLauncher.bat"
(@echo @start Vivaldi.exe --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --disable-background-networking --disable-component-update --no-default-browser-check)>"Vivaldi-bin-win64\VivaldiLauncher.bat"

@echo Done!
@pause > nul