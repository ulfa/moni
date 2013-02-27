-module(loggerl_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	application:start(mochiweb),
	application:start(webmachine),
	application:start(searcher),
	webmachine_sup:start_link(),
    loggerl_sup:start_link().

stop(_State) ->
    ok.
