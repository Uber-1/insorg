@echo off
@title Supermium downloader + configer + selfcleaner ^| ver.2.1 [13.10.2023]
@cd /d "%~dp0"
@set UseCURL=1
@if not exist "curl.exe" @if not exist "%SystemRoot%\SYSTEM32\curl.exe" (@set UseCURL=0)
@if /i "%1" EQU "ps" @set UseCURL=0
@if /i "%1" EQU "cu" @set UseCURL=1

@echo.
@echo Download...
@GOTO GetBrowJob%UseCURL%
:GetBrowJob0
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe', '7zr.exe')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/win32ss/supermium/releases/latest/download/mini_installer_32.exe', 'mini_installer_32.7z')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/win32ss/supermium/releases/latest/download/mini_installer_64.exe', 'mini_installer_64.7z')"
@GOTO GetBrowDone
:GetBrowJob1
@CURL -RLO# "https://www.7-zip.org/a/7zr.exe"
@CURL -RL# "https://github.com/win32ss/supermium/releases/latest/download/mini_installer_32.exe" -o "mini_installer_32.7z"
@CURL -RL# "https://github.com/win32ss/supermium/releases/latest/download/mini_installer_64.exe" -o "mini_installer_64.7z"
:GetBrowDone

@echo.
@echo Unpack...
@7zr.exe x -t7z -bso0 -aoa "mini_installer_32.7z" -o"." &&@rename chrome.7z chrome32.7z &&@7zr.exe rn -bso0 "chrome32.7z" Chrome-bin Supermium-win32 &&@rd /q /s "Supermium-win32"
@7zr.exe x -t7z -bso0 -aoa "mini_installer_64.7z" -o"." &&@rename chrome.7z chrome64.7z &&@7zr.exe rn -bso0 "chrome64.7z" Chrome-bin Supermium-win64 &&@rd /q /s "Supermium-win64"
@7zr.exe x -t7z -bso0 -aoa "chrome*.7z" -o"." -xr!af.pak -xr!am.pak -xr!ar.pak -xr!as.pak -xr!az.pak -xr!bg.pak -xr!bn.pak -xr!bs.pak -xr!ca.pak -xr!ca-Es-VALENCIA.pak -xr!cs.pak -xr!cy.pak -xr!da.pak -xr!de.pak -xr!el.pak -xr!en-GB.pak -xr!es.pak -xr!es-419.pak -xr!et.pak -xr!eu.pak -xr!fa.pak -xr!fi.pak -xr!fil.pak -xr!fr.pak -xr!fr-CA.pak -xr!ga.pak -xr!gd.pak -xr!gl.pak -xr!gu.pak -xr!he.pak -xr!hi.pak -xr!hr.pak -xr!hu.pak -xr!id.pak -xr!is.pak -xr!it.pak -xr!ja.pak -xr!ka.pak -xr!kk.pak -xr!km.pak -xr!kn.pak -xr!ko.pak -xr!kok.pak -xr!lb.pak -xr!lo.pak -xr!lt.pak -xr!lv.pak -xr!mi.pak -xr!mk.pak -xr!ml.pak -xr!mr.pak -xr!ms.pak -xr!mt.pak -xr!nb.pak -xr!ne.pak -xr!nl.pak -xr!nn.pak -xr!or.pak -xr!pa.pak -xr!pt-BR.pak -xr!pt-PT.pak -xr!qu.pak -xr!ro.pak -xr!sk.pak -xr!sl.pak -xr!sq.pak -xr!sr.pak -xr!sr-Cyrl-BA.pak -xr!sr-Latn-RS.pak -xr!sw.pak -xr!sv.pak -xr!ta.pak -xr!te.pak -xr!th.pak -xr!tr.pak -xr!tt.pak -xr!ug.pak -xr!ur.pak -xr!vi.pak -xr!zh-CN.pak -xr!zh-TW.pak
@del /q "chrome32.7z" "chrome64.7z" "mini_installer*.7z" "7zr.exe"

@echo.
@echo version.dll...
@GOTO GetDllJob%UseCURL%
:GetDllJob0
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++32.dll', 'Supermium-win32\version.dll')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++64.dll', 'Supermium-win64\version.dll')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++.ini', 'Supermium-win32\chrome++.ini')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++.ini', 'Supermium-win64\chrome++.ini')"
@GOTO GetDllDone
:GetDllJob1
@CURL -RL# "https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++32.dll" -o "Supermium-win32\version.dll"
@CURL -RL# "https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++64.dll" -o "Supermium-win64\version.dll"
@CURL -RL# "https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++.ini" -o "Supermium-win32\chrome++.ini"
@CURL -RL# "https://github.com/Bush2021/chrome_plus/raw/main/setdll/chrome++.ini" -o "Supermium-win64\chrome++.ini"
:GetDllDone

@echo Config...
@md "Data\Default\"
@set cr_masp1={"distribution":{"alternate_shortcut_text":false,"chrome_shortcut_icon_index":0,"create_all_shortcuts":true,"do_not_create_desktop_shortcut":true,"do_not_create_quick_launch_shortcut":true,"do_not_create_taskbar_shortcut":true,"do_not_launch_chrome":true,"do_not_register_for_update_launch":true,"import_bookmarks":false,"import_history":false,"import_home_page":false,"import_search_engine":false,"make_chrome_default":false,"make_chrome_default_for_user":false,"show_welcome_page":false,"skip_first_run_ui":true,"system_level":false,"verbose_logging":false},"first_run_tabs":[],"homepage":"chrome://chrome-urls","homepage_is_newtabpage":false,"safebrowsing":{"enabled":false},"session":{"restore_on_startup":1},"alternate_error_pages":{"enabled":false},"NewTabPage":{"DisabledModules":["dummy","dummy2"],"ModulesVisible":false},"account_id_migration_state":2,"autofill":{"credit_card_enabled":false,"enabled":false,"orphan_rows_removed":true,"profile_enabled":false},"bookmark_bar":{"show_apps_shortcut":false,"show_on_all_tabs":false,"show_only_on_ntp":true,"show_reading_list":false},"browser":{"show_home_button":true,"check_default_browser":false,"clear_data":{"browsing_history_basic":true,"cache_basic":true,"cookies_basic":true,"form_data":true,"hosted_apps_data":true,"media_licenses":true,"passwords":true,"preferences_migrated_to_basic":true,"site_settings":true,"time_period":4,"time_period_basic":4},"clear_lso_data_enabled":true,"has_seen_welcome_page":true,"last_clear_browsing_data_tab":1,"window_placement":{"bottom":720,"left":64,"maximized":true,"right":1200,"top":32}},"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state":2,"download":{"directory_upgrade":true,"prompt_for_download":true},"enable_do_not_track":true,"extensions":{"alerts":{"initialized":true},"ui":{"developer_mode":true}},"media":{"engagement":{"schema_version":4}},"net":{"network_prediction_options":2},"omnibox":{"prevent_url_elisions":true},"payments":{"can_make_payment_enabled":false},"profile":{"avatar_index":24,"block_third_party_cookies":true,"content_settings":{"clear_on_exit_migrated":true,"pref_version":1},"default_content_setting_values":{"background_sync":2,"cookies":1},"exit_type":"Normal","exited_cleanly":true,"local_avatar_index":24,"managed_user_id":"","name":"","password_manager_enabled":false},"search":{"suggest_enabled":false}}
@set cr_loca1={"background_mode":{"enabled":false},"browser":{"enabled_labs_experiments":["force-xp-theme@1","ignore-gpu-blocklist","smooth-scrolling@2"]},"hardware_acceleration_mode_previous":true,"profile":{"last_used":"Default"}}
@set cr_pref1={"NewTabPage":{"DisabledModules":["dummy","dummy2"],"ModulesVisible":false},"account_id_migration_state":2,"autofill":{"credit_card_enabled":false,"enabled":false,"orphan_rows_removed":true,"profile_enabled":false},"bookmark_bar":{"show_apps_shortcut":false,"show_on_all_tabs":false,"show_reading_list":false},"browser":{"check_default_browser":false,"clear_data":{"browsing_history_basic":true,"cache_basic":true,"cookies_basic":true,"form_data":true,"hosted_apps_data":true,"media_licenses":true,"passwords":true,"preferences_migrated_to_basic":true,"site_settings":true,"time_period":4,"time_period_basic":4},"clear_lso_data_enabled":true,"has_seen_welcome_page":true,"last_clear_browsing_data_tab":1,"window_placement":{"bottom":720,"left":64,"maximized":false,"right":1200,"top":32}},"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state":2,"download":{"directory_upgrade":true,"prompt_for_download":true},"enable_do_not_track":true,"extensions":{"alerts":{"initialized":true},"ui":{"developer_mode":true}},"media":{"engagement":{"schema_version":4}},"net":{"network_prediction_options":2},"omnibox":{"prevent_url_elisions":true},"payments":{"can_make_payment_enabled":false},"profile":{"avatar_index":24,"block_third_party_cookies":true,"content_settings":{"clear_on_exit_migrated":true,"pref_version":1},"default_content_setting_values":{"background_sync":2,"cookies":1},"exit_type":"Normal","exited_cleanly":true,"local_avatar_index":24,"managed_user_id":"","name":"","password_manager_enabled":false},"safebrowsing":{"enabled":false,"unhandled_sync_password_reuses":{}},"savefile":{"default_directory":"::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"},"search":{"suggest_enabled":false},"zerosuggest":{"cachedresults":""}}
(@echo %cr_masp1%)>"Supermium-win32\master_preferences"
(@echo %cr_masp1%)>"Supermium-win64\master_preferences"
@if exist "Data\Local State" @GOTO SkipUserData
(@echo %cr_loca1%)>"Data\Local State"
(@echo %cr_pref1%)>"Data\Default\Preferences"
:SkipUserData
(@echo @cd Supermium-win32 &@echo @start Chrome.exe --user-data-dir=..\Data --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --no-default-browser-check)>"Supermium-win32-Launcher.bat"
(@echo @cd Supermium-win64 &@echo @start Chrome.exe --user-data-dir=..\Data --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --no-default-browser-check)>"Supermium-win64-Launcher.bat"
:: (@echo @cd Supermium-win32 &@echo @start Chrome.exe --user-data-dir=..\Data --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --no-default-browser-check --test-type --no-sandbox)>"Supermium-win32-Launcher--no-sandbox.bat"
:: (@echo @cd Supermium-win64 &@echo @start Chrome.exe --user-data-dir=..\Data --disable-gpu-shader-disk-cache --disk-cache-dir=nul --disk-cache-size=1 --no-default-browser-check --test-type --no-sandbox)>"Supermium-win64-Launcher--no-sandbox.bat"

@echo Done!
@pause