# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::ruby::cli::bundle()
#
#  Environment:	 GEM_HOME
#>
######################################################################
p6df::modules::ruby::cli::bundle() {

    local cwd=$(pwd)
    local name=$(p6_uri_name "$cwd")
    local date=$(p6_dt_now)
    local ruby_ver=$(ruby -v | awk '{print $2}')
    local sha=$(p6_git_util_sha_short_get)

    local gemset="${name}_${ruby_ver}_${date}_${sha}"

    p6_echo "$gemset" >.rbenv-gemsets

    bundle install
    rbenv gemset list
    p6_msg $GEM_HOME

    p6_return_void
}
