
-module(peterson).
-export([start/1]).

start(Next_PID) ->
  loop(Next_PID, Next_PID, active).

loop(Next_PID, Candidate, active) ->
  Next_PID ! {one, Candidate},
  receive
    {one, Neighbor} ->
      if
        Candidate == Neighbor ->
          Next_PID ! {leader, Candidate};
        true ->
          Next_PID ! {two, Neighbor},
          receive
            {two, Id} ->
              if
                Id > Neighbor andalso Candidate > Neighbor ->
                  loop(Next_PID, Neighbor, active);
                true ->
                  loop(Next_PID, Candidate, passive)
              end
          end
      end
  end;

loop(Next_PID, Candidate, passive) ->
  receive
    {one, Id} ->
      Next_PID ! {one, Id},
      receive
        {leader, Id} ->
          Next_PID ! {leader, Id},
          elect(Next_PID, Id);
        {two, Id} ->
          Next_PID ! {two, Id},
          loop(Next_PID, Candidate, passive)
      end
  end.

elect(Next_PID, Leader) ->
  io:format("~p's leader is ~p~n", [Next_PID, Leader]),
  Leader.
