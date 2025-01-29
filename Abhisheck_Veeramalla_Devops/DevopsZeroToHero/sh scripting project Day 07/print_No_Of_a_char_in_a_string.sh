#!/bin/bash

x=mississippi

grep -o "s" <<<"$x" | wc -l
