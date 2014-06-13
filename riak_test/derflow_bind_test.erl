%% @doc Test that a bind works on a distributed cluster of nodes.

-module(derflow_bind_test).
-author("Christopher Meiklejohn <cmeiklejohn@basho.com>").

-ifdef(TEST).

-export([confirm/0]).

-define(HARNESS, (rt_config:get(rt_harness))).

-include_lib("eunit/include/eunit.hrl").

confirm() ->
    [Nodes] = rt:build_clusters([3]),
    lager:info("Nodes: ~p", [Nodes]),

    Node = hd(Nodes),

    {ok, Id} = derflow_test_helpers:declare(Node),

    {ok, NextId} = derflow_test_helpers:bind(Node, Id, 1),
    lager:info("NextId: ~p", [NextId]),

    {ok, Value, NextId} = derflow_test_helpers:read(Node, Id),
    lager:info("Value: ~p", [Value]),

    ?assertEqual(1, Value),

    pass.

-endif.
