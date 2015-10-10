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
