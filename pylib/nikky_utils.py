import os, json, inspect
from plpy_wrapper import PLPYWrapper,Trigger

plpy = None
SD = {}
GD = {}

class DummyPlPy():
    pass


def insighter(plpy_globals: DummyPlPy):

    global plpy, SD, GD
    plpy = plpy_globals['plpy']
    SD = plpy_globals['SD']
    GD = plpy_globals['GD']


    # plpy.log(f'LEGARCIA')
    pw = PLPYWrapper(plpy_globals)

    plpy_items = { x: f'{type(getattr(pw, x))}' for x in dir( pw )  }

    for key, val in plpy_items.items():
        if 'builtin_function_or_method' in val:
            # argspec = inspect.getargspec(getattr(plpy, key))
            plpy_items[key] = f'function params {type(getattr(plpy, key))}'


    return {'plpy_items1':  plpy_items  }



