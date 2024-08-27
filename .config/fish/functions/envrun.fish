function envrun
  begin
    set -l envfile $argv[1]
    set -l cmd $argv[2..(count $argv)]

    # load environment variables
    # https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc
    for line in (cat $envfile | grep -v '^#' | grep -v '^\s*$')
      set item (string split -m 1 '=' $line)
      set -x $item[1] (string trim --chars=\'\" $item[2])
    end

    eval "$cmd"
  end
end

