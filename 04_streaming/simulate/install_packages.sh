#!/bin/bash
conda install pytz
pip install timezonefinder==3.0.0
conda install "PyYAML<4.0.0,>=3.12"
pip install 'apache-beam[gcp]'
