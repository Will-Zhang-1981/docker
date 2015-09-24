-------------------------------------------------------------------------------
-- When you want to alias an email to another email you use this table.
-------------------------------------------------------------------------------

CREATE TABLE aliases (
  id uuid default uuid_generate_v4() NOT NULL,
  lookup text NOT NULL,
  destination text NOT NULL,
  active boolean DEFAULT true,
  created timestamp WITH time zone DEFAULT now(),
  PRIMARY KEY (id)
);

ALTER TABLE public.aliases OWNER TO dovefix;
CREATE INDEX aliases_active_idx ON aliases USING btree (active);
CREATE INDEX aliases_lookup_idx ON aliases USING btree (lookup);

-------------------------------------------------------------------------------
-- For security purposes you should delegate who can send mail as who.
-------------------------------------------------------------------------------

CREATE TABLE delegates (
  id uuid default uuid_generate_v4() NOT NULL,
  username text NOT NULL,
  sendas text NOT NULL,
  active boolean DEFAULT true,
  created timestamp WITH time zone DEFAULT now(),
  PRIMARY KEY (id)
);

ALTER TABLE public.delegates OWNER TO dovefix;
CREATE INDEX delegates_sendas_idx ON delegates USING btree (sendas);
CREATE INDEX delegates_active_idx ON delegates USING btree (active);

-------------------------------------------------------------------------------
-- Again, this is used for security, to determine which domains are active.
-- So That if a domain is inactive, then it automatically invalidates all users
-- on that domain without you having to really give a shit.
-------------------------------------------------------------------------------

CREATE TABLE domains (
  id uuid default uuid_generate_v4() NOT NULL,
  domain text UNIQUE NOT NULL,
  active boolean DEFAULT true,
  backup boolean DEFAULT false,
  created timestamp WITH time zone DEFAULT now(),
  PRIMARY KEY (id)
);

ALTER TABLE public.domains OWNER TO dovefix;
CREATE INDEX domains_domain_idx ON domains USING btree (domain);
CREATE INDEX domains_active_idx ON domains USING btree (active);
CREATE INDEX domains_backup_idx ON domains USING btree (backup);

-------------------------------------------------------------------------------

CREATE TABLE users (
  id uuid default uuid_generate_v4() NOT NULL,
  username text UNIQUE NOT NULL,
  password text NOT NULL,
  active boolean default true,
  created timestamp WITH time zone DEFAULT now(),
  PRIMARY KEY (id)
);

ALTER TABLE public.users OWNER TO dovefix;
CREATE INDEX users_active_idx ON users USING btree (active);
CREATE INDEX users_username_idx ON users USING btree (username);
