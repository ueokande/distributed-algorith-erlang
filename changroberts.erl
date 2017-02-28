-module(changroberts).
-export([start/1]).

start(Next_PID) ->
  loop(Next_PID).

loop(Next_PID) ->
  Next_PID ! {candidate, self()},
  receive
    {candidate, Received_PID} ->
      if
        self() == Received_PID ->
          Next_PID ! {leader, Received_PID};
        self() > Received_PID ->
          Next_PID ! {candidate, Received_PID};
        true ->
          ok
      end,
      loop(Next_PID);
    {leader, Received_PID} ->
      if 
        Received_PID /= self() ->
          Next_PID ! {leader, Received_PID},
        true ->
          ok
      end,
      io:format("~p's leader is ~p~n", [self(), Received_PID])
  end.
