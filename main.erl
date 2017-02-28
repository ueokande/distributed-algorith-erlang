-module(main).
-export([main/0]).

main() ->
  PID1 = spawn(changroberts, start, [self()]),
  PID2 = spawn(changroberts, start, [PID1]),
  PID3 = spawn(changroberts, start, [PID2]),
  PID4 = spawn(changroberts, start, [PID3]),
  PID5 = spawn(changroberts, start, [PID4]),
  PID6 = spawn(changroberts, start, [PID5]),
  PID7 = spawn(changroberts, start, [PID6]),
  changroberts:start(PID7).
