# protocol_check

Dedicated Github action to check protocols in repository `github.com/inbo/protocolsource` for shortcomings by running `protocolhelper::check_all()` in `entrypoint_check.sh`.
If needed, it updates protocol the version number as well (by running `protocolhelper::update_version_number()`).
