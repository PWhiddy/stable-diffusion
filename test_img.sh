#!/bin/bash
conda run -n ldm python scripts/txt2img.py --prompt "$@" --plms
