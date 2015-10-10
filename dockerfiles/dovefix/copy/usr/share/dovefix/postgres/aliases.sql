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
