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
