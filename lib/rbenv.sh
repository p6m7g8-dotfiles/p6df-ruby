# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::latest()
#
#>
######################################################################
p6df::modules::ruby::rbenv::latest() {

    rbenv install -l 2>&1 | grep "^[0-9]" | p6_filter_last "1"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::latest::installed()
#
#>
######################################################################
p6df::modules::ruby::rbenv::latest::installed() {

    rbenv install -l 2>&1 | p6_filter_select "[a-z]" | p6_filter_select "[0-9]" | p6_filter_last "1"
}
