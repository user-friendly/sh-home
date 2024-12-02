# from IPython.core.formatters import PlainTextFormatter
from IPython import get_ipython

# Access the current IPython instance
ip = get_ipython()

# Default plan text formatter - PlainTextFormatter
ptf = ip.display_formatter.formatters['text/plain']

def get_fractional_part(float_str):
    return float_str.split(".")[1] if "." in float_str else "0"

def custom_int_format(value, p, cycle):
    if cycle:
        return p.pretty(value)
    if isinstance(value, int):
        return p.text(f"{value:,}")
    return p.pretty(value)

def custom_float_format(value, p, cycle):
    if cycle:
        return p.pretty(value)
    if isinstance(value, float):
        text = (ptf.float_format%value).split(".")
        custom_int_format(int(text[0]), p, cycle)
        return p.text("." + text[1])
    return p.pretty(value)

# Attach the formatter to integers
ip.display_formatter.formatters['text/plain'].for_type(int, custom_int_format)
ip.display_formatter.formatters['text/plain'].for_type(float, custom_float_format)
