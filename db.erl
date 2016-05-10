-module(db).
-export([new/0, put/3, get/2, delete/2, find/2, filter/2, reduce/2]).

filter(Pred, List) -> [X || X <- List, Pred(X)].

reduce(Func, [Head | Tail]) -> reduce(Func, Head, Tail).
reduce(_, First, []) -> [First];
reduce(Func, First, [Head | Tail]) -> reduce(Func, Func(First, Head), Tail).

new() -> [].

put(Key, Value, []) -> [{Key, Value}];
put(Key, Value, [{Key, _} | Tail]) -> [{Key,Value} | Tail];
put(Key, Value, [Head | Tail]) -> [Head | put(Key, Value, Tail)]. 

get(_, []) -> {error, "Key not exists"};
get(Key, [{Key, Value} | _]) -> Value;
get(Key, [_ | Tail]) -> get(Key, Tail).

delete(Key, Db) -> 
    filter(
        fun({XKey, _}) -> XKey =/= Key end,
        Db
    ).

find(Value, Db) -> [XKey || {XKey, XValue} <- Db, XValue =:= Value].