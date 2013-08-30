%% Copyright (c) 2013 Ulf Angermann
%% See MIT-LICENSE for licensing information.

%%% -------------------------------------------------------------------
%%% Author  : Ulf Angermann uaforum1@googlemail.com
%%% Description :
%%%
%%% Created : 

-module(login).

-export([login/2]).

-include_lib("webmachine/include/webmachine.hrl").

login(ReqData, Context) ->

	case wrq:get_req_header("authorization", ReqData) of
		"Basic " ++ Base64 -> Str = base64:mime_decode_to_string(Base64),
			[Account, Password] = string:tokens(Str, ":"),
			case account:is_valid_account(Account, Password) of
				true -> lager:info("sucessful login"),
						{true, ReqData, Context};
                false-> lager:error("Account : ~p, password: ~p  wrong", [Account, Password]),
                		{"Basic realm=Webmachine", ReqData, Context}
             end;
                		_ -> {"Basic realm=Webmachine", ReqData, Context}
	end.

%% --------------------------------------------------------------------
%%% Test functions
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
-ifdef(TEST).
-endif.