-module(listsdb).
-export([new/0, put/3, get/2, delete/2, find/2, filter/2, reduce/2]).

filter(Pred, List) -> lists:filter(Pred, List).

reduce(Func, [Head | Tail]) -> reduce(Func, Head, Tail).
reduce(Func, First, List) -> lists:foldl(Func, First, List).

new() -> [].

put(Key, Value, Db) -> lists:keystore(Key, 1, Db, {Key, Value}]).

get(Key, Db) -> 
    case lists:keyfind(Key, 1, Db) of
        {_, Value} -> Value;
        false -> {error, "Key not found"}
    end.

delete(Key, Db) -> lists:keydelete(Key, 1, Db).

find(Value, Db) -> 
    lists:map(
        fun({Key, _}) -> Key end,
        lists:filter(
            fun({_, XValue}) -> XValue =:= Value end,
            Db
        )
    ).