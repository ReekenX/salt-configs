Salt configurations
-------------------

Custom salt configurations for personal use.

Some notes about structure
--------------------------

Scripts which are used only once (fe. by `salt SERVER state.sls FILE`) MUST be
placed in `sls` folder.

Recommendation is always to use `highstate mode` to make sure all servers are
configured properly.

This repo doesn't contain /resources/backups/ folder. If you need this - update
with your own content.

Bugs
----

Feel free to file any bug report, suggestion or question report to this repo
GitHub issues tracker. Normally will respond in less than a day.
