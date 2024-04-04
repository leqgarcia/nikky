
-- UPDATE pg_settings SET setting = "pg_cron" WHERE name = 'shared_preload_libraries';
-- UPDATE pg_settings SET setting = "postgres" WHERE name = 'cron.database_name';

CREATE EXTENSION plpython3u;

CREATE EXTENSION pg_cron;


create or replace function version() returns text as
$$
  return f'0.0.1'
$$ language plpython3u;

create or replace function python_version() returns text as
$$
  import sys
  plpy.execute('''SELECT set_config('response.headers', '[{"Content-Type": "text/json"}, {"Cache-Control": "no-cache, no-store, must-revalidate"} ]', true); ''')
  return f'["python_version" : "{sys.version_info}"]'
$$ language plpython3u;

SELECT public."python_version"();