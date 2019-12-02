krewdirs=("${HOME}/.krew" )

FOUND_KREW=0
for krewdir in $krewdirs; do
    if [[ -d "${krewdir}" ]]; then
        FOUND_KREW=1
        break
    fi
done

if [[ $FOUND_KREW -eq 1 ]]; then
    export KREW_ROOT=${krewdir}
    export PATH=${KREW_ROOT}/bin:$PATH
else
fi

unset krewdir krewdirs FOUND_KREW
