# protocol_check

Dedicated Github action to check protocols in repository `github.com/inbo/protocolsource` for shortcomings by running R script `docker/check_all.R` in this repository.
If needed, it updates protocol the version number as well (by running `protocolhelper::update_version_number()`).
