
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp" if you wanted to use more advanced  uuid_generate_v4()

create table instackjobs (
  id uuid DEFAULT gen_random_uuid() NOT NULL,
  name text unique,
  jdata json
);



-- DROP TABLE public.files;

CREATE TABLE public.files (
	id serial4 NOT NULL,
	"blob" bytea NULL,
	"type" text NULL,
	"name" text NULL,
	CONSTRAINT files_pkey PRIMARY KEY (id)
);