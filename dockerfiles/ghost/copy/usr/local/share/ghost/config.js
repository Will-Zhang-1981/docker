var   path = require("path");
var config = {
  production: {
    url: "http://" + (process.env.DOMAIN || "localhost") + ":" + (process.env.PORT || "4000"),
    smtp: {},

    paths: {
      contentPath: "/srv/ghost"
    },

    database: {
      client: "sqlite3",
      debug: false,
      connection: {
        filename: "/srv/ghost/data/ghost.db"
      }
    },

    server: {
      port: process.env.PORT || 4000,
      host: process.env.LISTEN_ADDRESS || "0.0.0.0"
    }
  }
};

if (process.env.SMTP_SERVICE) {
  config.production.smtp = {
    mail: {
      transport: "SMTP",
      options: {
        service: process.env.SMTP_SERVICE || "Mandrill", auth: {
           user: process.env.SMTP_USER,
           pass: process.env.SMTP_PASS
        }
      }
    }
  };
}

if (process.env.DATABASE_TYPE && process.env.DATABASE_TYPE.toLowerCase() != "sqlite") {
  config.production.database = {
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

module.exports = config;
