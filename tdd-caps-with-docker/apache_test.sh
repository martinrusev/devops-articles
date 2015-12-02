#!/usr/bin/env bats

@test "Check if the apache server is available" {
    command -v apache2
}