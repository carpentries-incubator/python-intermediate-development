#!/bin/bash
for i in *.md; do
    if [[ $i == "README.md" ]]; then
        continue
    fi
    jupytext --from md:markdown --to notebook --output - "$i" | jupyter nbconvert --stdin --to slides --embed-images --output $(basename -s ".md" "$i")
done
