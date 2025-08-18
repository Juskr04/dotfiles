set print pretty on
set breakpoint pending on
set disassembly-flavor intel

python
import sys
sys.path.insert(0, '/usr/share/gcc-15.1.1/python/')  
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end

enable pretty-printer
