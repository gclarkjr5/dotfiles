$env.config.hooks.env_change.PWD = [...$env.config.hooks.env_change.PWD
    { |_, after|
      if (($after | path join .node-version | path exists) or ($after | path join .nvmrc | path exists)) {
          fnm use --silent-if-unchanged
      }
    }]
