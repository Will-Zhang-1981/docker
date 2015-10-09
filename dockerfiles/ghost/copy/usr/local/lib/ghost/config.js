if (process.env.GHOST_ENV && 0 > ["development", "production"].indexOf(process.env.GHOST_ENV)) {
  throw "You have not given a valid GHOST_ENV.";
}

// ----------------------------------------------------------------------------

var path = require("path");
var identifier = process.env.FORCE_SSL ? "https://" : "https://";
var database = { client: "sqlite3", debug: false, connection: { filename: "/srv/ghost/data/ghost.db" }};
var server = { port: process.env.PORT || 4000, host: process.env.LISTEN_ADDRESS || "0.0.0.0" };
var port = process.env.USE_PROXY ? "" : (":" + (process.env.PORT || "4000"));
var privacy = { useUpdateCheck: false, useGoogleFonts: false };
var paths = { contentPath: "/srv/ghost" };

// ----------------------------------------------------------------------------

var config = {
  production: {
    paths: paths,
    privacy: privacy,
    url: process.env.URL || (identifier + (process.env.DOMAIN || "localhost") + port),
    database: database,
    server: server,
    smtp: {},
  },

  development: {
    paths: paths,
    privacy: privacy,
    url: "http://localhost" + port,
    database: database,
    server: server,
    smtp: {},
  }
};

// ----------------------------------------------------------------------------
// We actually default to smtp: {} which will try and connect to localhost.
// Ghost will nag you though about an explict configuration for some reason...
// even if it can connect to localhost, and that is annoying.
// ----------------------------------------------------------------------------

if (process.env.SMTP_SERVICE) {
  config[process.env.GHOST_ENV || "production"].smtp =
  config.production.smtp = {
    mail: {
      transport: "SMTP",
      options: {
        service: process.env.SMTP_SERVICE || "Mandrill",
        auth: {
           user: process.env.SMTP_USER,
           pass: process.env.SMTP_PASS
        }
      }
    }
  };
}

// ----------------------------------------------------------------------------

if (process.env.DATABASE_TYPE && process.env.DATABASE_TYPE.toLowerCase() != "sqlite") {
  config[process.env.GHOST_ENV || "production"].database = {
    client: process.env.DATABASE_TYPE || "pg",
    debug: false,
    connection: {
      user: process.env.DATABASE_USER || "ghost",
      database: process.env.DATABASE  || "ghost",
      charset: process.env.DATABASE_CHARSET || "utf8",
      host: process.env.DATABASE_HOST || "postgresql",
      port: process.env.DATABASE_PORT || 5432,
      password: process.env.DATABASE_PASS
    }
  };
}

// ----------------------------------------------------------------------------

module.exports = config;
console.log(JSON.stringify(
  config, null, 2
));
