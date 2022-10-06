# protocol_website

Dedicated Github action to render new protocols in repository `github.com/inbo/protocolsource` using `protocolhelper::render_release()` and add the website to repository `github.com/inbo/protocols`.
In both repositories (protocolsource and protocols), a tag is added to the last commit using (`protocolhelper::set_tags()`).
