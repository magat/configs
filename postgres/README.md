# PostgreSQL in a container

An easy way to have a local postgres environment, without installing postgres on your machine.

Allows persistant storage via volumes, for :
- postgres configuration
- data files
- logs

## Usage

```
cd container && make # Build the docker image

./start.sh # Start the container
```


## Warning

The postgres configuration is optimized for local development.

DO NOT USE AS IS IN PRODUCTION 
