# protocol_update

Dedicated Github action to add information on the new protocol to the general `.zenodo.json` and the general `NEWS.md` in repository `github.com/inbo/protocolsource` by running `protocolhelper` internal functions `update_zenodo()` and `update_news_release()`.

The action also runs the internal function `update_doi()` to add or update the protocol-specific Zenodo DOI.
