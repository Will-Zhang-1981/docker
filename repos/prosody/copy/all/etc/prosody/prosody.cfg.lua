use_libevent = true;
admins = {
}

----
-- SEE: http://prosody.im/doc/modules
--      ^ Supports XEP searches BTW!1
----

modules_enabled = {
  "roster"; "saslauth"; "tls"; "dialback"; "disco"; "private";
  "vcard"; "privacy"; "compression"; "posix";
  "announce"; "ping";
};

modules_disabled = {
	-- "offline";
	-- "c2s";
	"s2s";
};

allow_registration = false;
pidfile = "/var/run/prosody/prosody.pid";
daemonize = false;

-- s2s_secure_auth = true -- enable:ssl
-- c2s_require_encryption = true -- enable:ssl
-- s2s_secure_auth = false -- disable:ssl
-- c2s_require_encryption = false -- disable:ssl
authentication = "internal_hashed"
storage = "internal"

log = {
	error = "/var/log/prosody/prosody.err";
	info  = "/var/log/prosody/prosody.log";
	{
		to = "syslog";
		levels = {
			"error"
		};
	};
}

VirtualHost "__HOSTNAME__"
	enabled = true
	-- ssl = { -- enable:ssl
		-- key = "/var/ssl/__HOSTNAME__.key"; -- enable:ssl
		-- certificate = "/var/ssl/__HOSTNAME__.crt"; -- enable:ssl
	-- } -- enable:ssl

-- Include "conf.d/*.cfg.lua"
