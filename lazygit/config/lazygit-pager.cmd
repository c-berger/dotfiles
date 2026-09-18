@echo off
rem ###########################################################################
rem External diff renderer for lazygit (GIT_EXTERNAL_DIFF argument order:
rem   path old-file old-hex old-mode new-file new-hex new-mode).
rem
rem Diffs the two temp files git hands us, then has delta display the real
rem repository path instead of those temp paths. The rewrite is done by delta
rem itself (--file-transformation) rather than a shell pipeline, because every
rem extra process spawn costs ~250 ms on this machine due to endpoint
rem protection scanning. Every path in a --no-index diff is a temp path, so
rem matching .* and substituting the real path is enough.
rem ###########################################################################

setlocal
set "WIDTH="
if defined LAZYGIT_COLUMNS set "WIDTH=--width=%LAZYGIT_COLUMNS%"
git diff --no-index --no-ext-diff "%~2" "%~5" | delta --file-transformation "s|.*|%~1|" %WIDTH%
