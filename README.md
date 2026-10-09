# SSH Pipeline

[Github actions](https://help.github.com/en/actions/creating-actions/creating-a-docker-container-action)

This action allows doing in order
* ssh if defined

## Image

The action runs a prebuilt image, `ghcr.io/abelnavarro/ssh-pipeline`, so a
run doesn't build the Dockerfile or pull anything from Docker Hub.
[`image.yml`](./.github/workflows/image.yml) publishes it when the image's
files change, and every Monday checks whether the base image
(`python:3.13-slim`, through `mirror.gcr.io`) has changed. If it has, it
rebuilds, tests (including a password ssh login against a local sshd) and
publishes, then commits the new digest to `action.yml`.

## Inputs
see the [action.yml](./action.yml) file for more detail imformation.

### `host`

**Required** ssh remote host.

### `port`

**NOT Required** ssh remote port. Default 22

### `user`

**Required** ssh remote user.

### `pass`

**NOT Required** ssh remote pass.

### `key`

**NOT Required** ssh remote key as string.

### `connect_timeout`

**NOT Required** connection timeout to remote host. Default 30s

### `script`

**NOT Required** execute commands on ssh.


## Usages
```yaml
- name: ssh pipelines
  uses: cross-the-world/ssh-pipeline@master
  env:
    WELCOME: "ssh pipeline"
  with:
    host: ${{ secrets.DC_HOST }}
    user: ${{ secrets.DC_USER }}
    pass: ${{ secrets.DC_PASS }}
    port: ${{ secrets.DC_PORT }}
    connect_timeout: 10s
    script: |
      (rm -rf /home/github/test || true)
      ls -la  
      echo $WELCOME 
      mkdir -p /home/github/test/test1 && 
      mkdir -p /home/github/test/test2 &&
```

  
