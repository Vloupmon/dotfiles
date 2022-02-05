# FUNCTIONS
## Upload tarball
function ul() {
    curl -s --upload-file $1 https://transfer.sh/ && echo ""
}

## Get dependencies of a bin.
## Requires `which` because `command -v` is terrible
## and gets around aliases by taking the last line.
## Could be buggy.
function deps() { objdump -p `which -a $1 | tail -n 1` \
    | grep "required" \
        | cut -d ' ' -f 5 \
        | sed 's/.$//g'
}

## Get EXAMPLE section from the manpages for a given command
## From @teddyh on Hackernews https://news.ycombinator.com/item?id=10802213
function eg() {
    MAN_KEEP_FORMATTING=1 man "$@" 2>/dev/null \
                        | sed --quiet --expression='/^E\(\x08.\)X\(\x08.\)\?A\(\x08.\)\?M\(\x08.\)\?P\(\x08.\)\?L\(\x08.\)\?E/{:a;p;n;/^[^ ]/q;ba}' \
                        | ${MANPAGER:-${PAGER:-pager -s}}
}

## Keep SSH session automatically open in a screen !
## From https://mazzo.li/posts/autoscreen.html
function autoscreen() {
    AUTOSSH_GATETIME=5 autossh -M 0 -- -o "ServerAliveInterval 5" -o "ServerAliveCountMax 1" -t $@ $'bash -c \'tmpScreenConfig=$(mktemp); echo "termcapinfo xterm* ti@:te" >> $tmpScreenConfig; echo "altscreen on" >> $tmpScreenConfig; echo "maptimeout 0" >> $tmpScreenConfig; echo "startup_message off" >> $tmpScreenConfig; echo "msgwait 0" >> $tmpScreenConfig; exec screen -c $tmpScreenConfig -S "autosession-'$RANDOM$RANDOM$RANDOM$RANDOM$'" -RD\''
}
