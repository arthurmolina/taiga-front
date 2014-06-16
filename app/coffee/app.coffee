# Copyright (C) 2014 Andrey Antukh <niwi@niwi.be>
# Copyright (C) 2014 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014 David Barragán Merino <bameda@dbarragan.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

@taiga = taiga = {}

configure = ($routeProvider, $locationProvider, $httpProvider, $provide, $compileProvider, $gmUrlsProvider) ->
    $routeProvider.when('/project/:pslug/backlog', {templateUrl: '/partials/backlog.html'})
    $routeProvider.otherwise({redirectTo: '/login'})
    $locationProvider.html5Mode(true);

    defaultHeaders = {
        "Content-Type": "application/json"
        "Accept-Language": "en"
    }

    $httpProvider.defaults.headers.delete = defaultHeaders
    $httpProvider.defaults.headers.patch = defaultHeaders
    $httpProvider.defaults.headers.post = defaultHeaders
    $httpProvider.defaults.headers.put = defaultHeaders
    $httpProvider.defaults.headers.get = {}

    # authHttpIntercept = ($q, $location) ->
    #     return (promise) ->
    #         return promise.then null, (response) ->
    #             if response.status == 401 or response.status == 0
    #                 $location.url("/login?next=#{$location.path()}")
    #             return $q.reject(response)
    # $provide.factory("authHttpIntercept", ["$q", "$location", authHttpIntercept])
    # $httpProvider.responseInterceptors.push('authHttpIntercept')


init = ($log, $rootScope) ->
    $log.debug("Initialize application")

configure.$inject = ["$routeProvider", "$locationProvider","$httpProvider"]
init.$inject = ["$log", "$rootScope"]

modules = [
    "ngRoute",
    "ngAnimate",

    "taigaConfig",
    "taigaResources",

    "taigaBacklog",
]

angular.module("taigaLocalConfig", []).value("localconfig", {})
module = angular.module("taiga", modules)
module.config(configure)
module.run(init)


