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
