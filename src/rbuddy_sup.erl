
-module(rbuddy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, {{one_for_one, 5, 10}, [
        {rbuddy_api, {rbuddy_api, start_link, []}, permanent, 5000, worker, [rbuddy_api]},
        {rbuddy, {rbuddy, start_link, []}, permanent, 5000, worker, [rbuddy]},
        {rbuddy_tcp_proxy_sup, {rbuddy_tcp_proxy_sup, start_link, []}, permanent, 5000, worker, [rbuddy_tcp_proxy_sup]},
        {rbuddy_slave_monitor_sup, {rbuddy_slave_monitor_sup, start_link, []}, permanent, 5000, worker, [rbuddy_slave_monitor_sup]},
        {rbuddy_tcp_listener, {rbuddy_tcp_listener, start_link, []}, permanent, 5000, worker, [rbuddy_tcp_listener]}
    ]}}.
