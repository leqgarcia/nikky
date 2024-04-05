

create domain "*/*" as bytea;

create function file(id int) returns "*/*" as
$$
  declare headers text;
  declare blob bytea;
  begin
    select format(
      '[{"Content-Type": "%s"},'
       '{"Content-Disposition": "inline; filename=\"%s\""},'
       '{"Cache-Control": "max-age=259200"}]'
      , files.type, files.name)
    from files where files.id = file.id into headers;
    perform set_config('response.headers', headers, true);
    select files.blob from files where files.id = file.id into blob;
    if FOUND -- special var, see https://www.postgresql.org/docs/current/plpgsql-statements.html#PLPGSQL-STATEMENTS-DIAGNOSTICS
    then return(blob);
    else raise sqlstate 'PT404' using
      message = 'NOT FOUND',
      detail = 'File not found',
      hint = format('%s seems to be an invalid file id', file.id);
    end if;
  end
$$ language plpgsql;


-- create or replace function template() returns json as
-- $$
--   import json
--   plpy.execute('''SELECT set_config('response.headers', '[{"Content-Type": "text/json"}, {"Cache-Control": "no-cache, no-store, must-revalidate"} ]', true); ''')


--   return json.dumps({})

-- $$ language plpython3u;
-- Create an event trigger function

CREATE OR REPLACE FUNCTION pgrst_watch() RETURNS text
  LANGUAGE plpgsql
  AS $$
BEGIN
  NOTIFY pgrst, 'reload schema';

  RETURN 'Done';
END;
$$;



CREATE OR REPLACE FUNCTION public.pylib_live_info()
 RETURNS json
 LANGUAGE plpython3u
AS $function$
  plpy.execute('SELECT * FROM public.pgrst_watch();')
  import json
  from nikky_utils import insighter
  plpy.execute('''SELECT set_config('response.headers', '[{"Content-Type": "text/json"}, {"Cache-Control": "no-cache, no-store, must-revalidate"} ]', true); ''')
  findings = insighter(globals())
  return json.dumps(findings)

$function$
;
