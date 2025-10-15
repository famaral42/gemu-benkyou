

# Container

## Execution

```Shell
run_pygame_container.sh -w /app pygame_img python -m teste_glow
```
```Shell
run_pygame_container.sh pygame_img pygbag --build /app/FlapPyBird
```
```Shell
run_pygame_container.sh -p 8000:8000 pygame_img python -m http.server --directory /app/FlapPyBird/build/web
```
```Shell
run_pygame_container.sh pygame_img python -m pygame_img.examples.aliens
```


## Image Creation

```Shell
podman build -f Dockerfile -t pygame_img
```

