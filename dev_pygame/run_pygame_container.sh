#!/usr/bin/env bash
set -euo pipefail


usage() {
    echo "Uso: $0 [opcoes_podman...] <nome_imagem> [comando [args...]]"
    echo "O script fornece volumes e dispositivos padrão para aplicações gráficas (X11, Áudio, DRM)."
    echo ""
    echo "Exemplos de Uso:"
    echo "  - Executar um módulo Python (jogo) com volume de trabalho customizado:"
    echo "    $0 -w /app pygame python -m teste_glow"
    echo ""
    echo "  - Executar um binário ou script (e.g., pygbag) dentro do container:"
    echo "    $0 pygame pygbag --build /app/FlapPyBird"
    echo ""
    echo "  - Iniciar um servidor HTTP no container (com mapeamento explícito de porta):"
    echo "    $0 -p 8000:8000 pygame python -m http.server --directory /app/FlapPyBird/build/web"
    echo ""
    echo "  - Executar um exemplo nativo do Pygame:"
    echo "    $0 pygame python -m pygame.examples.aliens"
    echo ""
    echo "  - Entrar no shell Bash do container (se nenhum comando for especificado):"
    echo "    $0 pygame bash"
}


command -v podman >/dev/null || { echo "Erro: 'podman' não encontrado no PATH."; exit 1; }
command -v xhost >/dev/null || { echo "Aviso: 'xhost' não encontrado. O acesso X pode falhar."; }


if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi


# MESA: error: Failed to query drm device.
# glx: failed to create dri3 screen
# failed to load driver: iris
DRM_DEVICE=$(ls /dev/dri/card* 2>/dev/null | head -n 1) # /dev/dri/card0

DRM_OPTION=""
if [ ! -z "$DRM_DEVICE" ]; then
    DRM_OPTION="--device $DRM_DEVICE"
fi


echo "Autorizando acesso do container ao display X (xhost +)..."
xhost +


podman run \
    --rm \
    --tty \
    --interactive \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --env DISPLAY="$DISPLAY" \
    $DRM_OPTION \
    --device /dev/snd:/dev/snd \
    --volume "$PWD":/app \
    "${@}" # TODOS OS ARGUMENTOS PASSADOS PELO USUÁRIO
