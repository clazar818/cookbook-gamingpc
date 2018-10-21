#!/bin/bash
berks vendor cookbooks # Use the berks file in this directory to bring down the cookbooks into a subfolder named cookbooks, which holds the vendored cookbooks. Run each time a change is made in the gamingpc cookbook.
chef-client -z -o gamingpc # Exec the Chef Client locally, against the gamingpc cookbook.