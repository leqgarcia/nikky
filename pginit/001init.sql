
-- UPDATE pg_settings SET setting = "pg_cron" WHERE name = 'shared_preload_libraries';
-- UPDATE pg_settings SET setting = "postgres" WHERE name = 'cron.database_name';

CREATE EXTENSION plpython3u;

CREATE EXTENSION pg_cron;

-------------------------------------------------------------------
create or replace function version() returns json as $$
## PYTHON
import json, os

return json.dumps({'ver':  os.getenv('APP_VERSION', 'not_set') })

$$ language plpython3u;



-------------------------------------------------------------------

create or replace function python_version() returns json as
$$
  import sys, json
  plpy.execute('''SELECT set_config('response.headers', '[{"Content-Type": "text/json"}, {"Cache-Control": "no-cache, no-store, must-revalidate"} ]', true); ''')

  # Create a list of component names
  comp = 'major minor micro releaselevel serial'.split()
  
  # Create a dictionary from sys.version_info
  svi_dic = {k: v for (k, v) in zip(comp, sys.version_info)}


  plpy_vars = f'{vars(plpy)}'

  plpy_dir = dir(plpy)
  
  return json.dumps({'nikky_plpython_ver': svi_dic,
                    'plpy_vars' : plpy_vars,
                    'plpy_dir'  : plpy_dir
                    })

$$ language plpython3u;

